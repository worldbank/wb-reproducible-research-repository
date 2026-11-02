library(readr)
library(readxl)
library(haven)
library(dplyr)
library(purrr)
library(janitor)
library(digest)
library(tools)
library(tibble)

# === CONFIG ===
pkg_path <- "package"
pub_path <- "public"
output_dir <- "."
output_summary <- "comparison_report.csv"
output_detailed <- "detailed_value_diffs.csv"
detailed_diff <- TRUE # <--- SET THIS TO TRUE if you want detailed diffs

# Sort rows before comparing, so that a different row order does not show up as differences.
# Rows are sorted by `sort_keys` (if given and present in the data), otherwise by all
# identifier-like columns (text columns and whole-number columns), then by the remaining columns.
sort_rows <- TRUE
sort_keys <- c() # e.g. c("cncode", "year"); names after clean_names()

# Relative tolerance for numeric differences (0.0005 = 0.05%).
# Differences below it are still listed in the detailed file, but noted as below tolerance
# and reported separately in the summary.
tolerance <- 0.0005

# Optional command-line override: Rscript compare_datasets.R <package_path> <public_path> <output_dir>
args <- commandArgs(trailingOnly = TRUE)
if (length(args) >= 1) pkg_path <- args[1]
if (length(args) >= 2) pub_path <- args[2]
if (length(args) >= 3) output_dir <- args[3]

dir.create(file.path(output_dir, "detailed_diffs"), showWarnings = FALSE, recursive = TRUE)
tolerance_label <- paste0(format(tolerance * 100, scientific = FALSE), "%")

# === FUNCTIONS ===
calculate_sha256 <- function(filepath) {
    tryCatch(digest::digest(file = filepath, algo = "sha256"), error = function(e) NA_character_)
}

is_id_column <- function(x) {
    if (is.character(x) || is.factor(x) || is.logical(x)) return(TRUE)
    if (is.numeric(x)) {
        x <- x[!is.na(x)]
        return(length(x) == 0 || all(x == round(x)))
    }
    FALSE
}

sort_dataset <- function(data, common_vars, id_vars) {
    other_vars <- setdiff(common_vars, id_vars)
    order_vars <- c(id_vars, other_vars)
    data %>% arrange(across(all_of(order_vars), ~ as.vector(.x)))
}

compare_column <- function(pkg_col, pub_col) {
    n <- min(length(pkg_col), length(pub_col))
    pkg_col <- as.vector(pkg_col[seq_len(n)])
    pub_col <- as.vector(pub_col[seq_len(n)])
    na_pkg <- is.na(pkg_col)
    na_pub <- is.na(pub_col)

    if (is.numeric(pkg_col) && is.numeric(pub_col)) {
        abs_diff <- abs(pkg_col - pub_col)
        denom <- pmax(abs(pkg_col), abs(pub_col))
        rel_diff <- ifelse(denom == 0, 0, abs_diff / denom)
        differs <- xor(na_pkg, na_pub) | (!na_pkg & !na_pub & pkg_col != pub_col)
    } else {
        abs_diff <- rep(NA_real_, n)
        rel_diff <- rep(NA_real_, n)
        differs <- xor(na_pkg, na_pub) |
            (!na_pkg & !na_pub & as.character(pkg_col) != as.character(pub_col))
    }
    below_tol <- differs & !is.na(rel_diff) & rel_diff < tolerance

    show_value <- function(x) {
        if (is.numeric(x)) ifelse(is.na(x), NA_character_, sprintf("%.15g", x)) else as.character(x)
    }

    tibble(
        row = seq_len(n),
        package_value = show_value(pkg_col),
        public_value = show_value(pub_col),
        abs_diff = abs_diff,
        rel_diff_pct = rel_diff * 100,
        note = ifelse(below_tol,
                      paste0("Difference below tolerance (<", tolerance_label, ")"),
                      "Difference above tolerance"),
        differs = differs
    ) %>%
        filter(differs) %>%
        select(-differs)
}

read_dataset <- function(file) {
    ext <- file_ext(file)
    switch(ext,
           csv = read_csv(file, show_col_types = FALSE),
           xlsx = read_excel(file),
           dta = read_dta(file),
           stop("Unsupported format: ", file)
    )
}

# === LOCALS ===
dataframe_types <- c('csv', 'xlsx', 'dta')

# === LOAD FILES ===
pkg_files <- list.files(pkg_path, full.names = TRUE, recursive = TRUE)
pub_files <- list.files(pub_path, full.names = TRUE, recursive = TRUE)
pkg_files <- pkg_files[tolower(basename(pkg_files)) != 'readme.md']
pub_files <- pub_files[tolower(basename(pub_files)) != 'readme.md']

# Match files with the same name and extension first (so data.dta and data.xlsx are both compared),
# then match the remaining files by name only (e.g. data.csv vs data.dta)
pkg_full <- tolower(basename(pkg_files))
pub_full <- tolower(basename(pub_files))
exact_matches <- intersect(pkg_full, pub_full)

pkg_rest <- pkg_files[!pkg_full %in% exact_matches]
pub_rest <- pub_files[!pub_full %in% exact_matches]
name_matches <- intersect(
    file_path_sans_ext(tolower(basename(pkg_rest))),
    file_path_sans_ext(tolower(basename(pub_rest)))
)

file_pairs <- c(
    lapply(exact_matches, function(nm) list(
        name = nm,
        pkg = pkg_files[pkg_full == nm][1],
        pub = pub_files[pub_full == nm][1]
    )),
    lapply(name_matches, function(nm) list(
        name = nm,
        pkg = pkg_rest[file_path_sans_ext(tolower(basename(pkg_rest))) == nm][1],
        pub = pub_rest[file_path_sans_ext(tolower(basename(pub_rest))) == nm][1]
    ))
)

summary_report <- list()
all_value_diffs <- list()

# === LOOP THROUGH MATCHED FILES ===
for (pair in file_pairs) {
    name <- pair$name
    pkg_file <- pair$pkg
    pub_file <- pair$pub
    sort_status <- ""

    # for data types
    if (tolower(file_ext(pkg_file)) %in% dataframe_types &
        tolower(file_ext(pub_file)) %in% dataframe_types) {
    
        pkg_data <- tryCatch(read_dataset(pkg_file), error = function(e) NULL)
        pub_data <- tryCatch(read_dataset(pub_file), error = function(e) NULL)
        if (is.null(pkg_data) || is.null(pub_data)) next
        
        pkg_data <- clean_names(pkg_data)
        pub_data <- clean_names(pub_data)
        
        vars_pkg <- names(pkg_data)
        vars_pub <- names(pub_data)
        common_vars <- intersect(vars_pkg, vars_pub)
        if (length(common_vars) == 0) next
        
        missing_in_pub <- setdiff(vars_pkg, vars_pub)
        missing_in_pkg <- setdiff(vars_pub, vars_pkg)
        
        vars_in_public_status <- if (length(missing_in_pub) == 0) {
            "All public variables are in package dataset"
        } else {
            paste("Missing in public:", paste(missing_in_pub, collapse = "; "))
        }
        
        vars_in_package_status <- if (length(missing_in_pkg) == 0) {
            "All package variables are in public dataset"
        } else {
            paste("Missing in package:", paste(missing_in_pkg, collapse = "; "))
        }
        
        row_match_status <- if (nrow(pkg_data) == nrow(pub_data)) {
            "Same number of rows"
        } else {
            paste0("Different number of rows: package = ", nrow(pkg_data), ", public = ", nrow(pub_data))
        }
        
        id_vars <- c()
        if (sort_rows) {
            id_vars <- intersect(sort_keys, common_vars)
            if (length(id_vars) == 0) {
                id_vars <- common_vars[sapply(common_vars, function(v)
                    is_id_column(pkg_data[[v]]) && is_id_column(pub_data[[v]]))]
            }
            pkg_data <- sort_dataset(pkg_data, common_vars, id_vars)
            pub_data <- sort_dataset(pub_data, common_vars, id_vars)
            sort_status <- if (length(id_vars) > 0) {
                paste("Rows sorted by:", paste(id_vars, collapse = "; "))
            } else {
                "Rows sorted by all common variables"
            }
        }

        # Identifier shown next to each difference (e.g. "AUT | 2018"), when there are few id columns
        row_ids <- if (sort_rows && length(id_vars) > 0 && length(id_vars) <= 5) {
            do.call(paste, c(lapply(id_vars, function(v) as.character(pkg_data[[v]])), sep = " | "))
        } else {
            NULL
        }

        value_diff_vars <- c()
        below_tol_vars <- c()
        type_mismatch_vars <- c()

        for (var in common_vars) {
            pkg_col <- pkg_data[[var]]
            pub_col <- pub_data[[var]]

            type_pkg <- typeof(pkg_col)
            type_pub <- typeof(pub_col)
            type_mismatch <- !identical(type_pkg, type_pub)

            diffs <- compare_column(pkg_col, pub_col) %>%
                mutate(
                    file = name,
                    variable = var,
                    type_package = type_pkg,
                    type_public = type_pub,
                    type_mismatch = ifelse(type_mismatch, "yes", "no"),
                    .before = 1
                ) %>%
                mutate(row_id = if (is.null(row_ids)) NA_character_ else row_ids[row], .after = row)

            if (nrow(diffs) > 0) {
                n_above <- sum(diffs$note == "Difference above tolerance")
                if (n_above > 0) {
                    value_diff_vars <- c(value_diff_vars, paste0(var, " (", n_above, " values)"))
                } else {
                    below_tol_vars <- c(below_tol_vars, paste0(var, " (", nrow(diffs), " values)"))
                }
                if (detailed_diff) {
                    all_value_diffs[[paste(name, var, sep = "_")]] <- diffs
                }
            }
            
            if (type_mismatch) {
                type_mismatch_vars <- c(type_mismatch_vars, paste0(var, " [", type_pkg, " vs ", type_pub, "]"))
            }
        }
        
        value_diff_summary <- if (length(value_diff_vars) > 0) {
            paste("Different values in:", paste(value_diff_vars, collapse = "; "))
        } else if (length(below_tol_vars) > 0) {
            paste0("All common variable values match within tolerance (<", tolerance_label, ")")
        } else {
            "All common variable values match"
        }

        below_tol_summary <- if (length(below_tol_vars) > 0) {
            paste0("Differences below tolerance (<", tolerance_label, ") in: ",
                   paste(below_tol_vars, collapse = "; "))
        } else {
            ""
        }
        
        type_diff_summary <- if (length(type_mismatch_vars) > 0) {
            paste("Type mismatches in:", paste(type_mismatch_vars, collapse = "; "))
        } else {
            "All data types match"
        }
    
    # Non-tabular data
    } else {
        row_match_status       <- ''
        vars_in_public_status  <- ''
        vars_in_package_status <- ''
        value_diff_summary     <- ''
        below_tol_summary      <- ''
        type_diff_summary      <- ''
    }
    
    hash_pkg <- calculate_sha256(pkg_file)
    hash_pub <- calculate_sha256(pub_file)
    hash_status <- if (identical(hash_pkg, hash_pub)) "hashes match" else "hashes differ"
    
    
    summary_report[[name]] <- tibble(
        file = name,
        package_ext = file_ext(pkg_file),
        public_ext = file_ext(pub_file),
        hash_pkg = hash_pkg,
        hash_pub = hash_pub,
        hash_status = hash_status,
        row_match_status = row_match_status,
        sort_status = sort_status,
        vars_in_public_status = vars_in_public_status,
        vars_in_package_status = vars_in_package_status,
        value_diff_summary = value_diff_summary,
        below_tolerance_summary = below_tol_summary,
        type_diff_summary = type_diff_summary
    )
}

# === EXPORT REPORTS ===
summary_df <- bind_rows(summary_report)
write_csv(summary_df, file.path(output_dir, output_summary))
message("Summary report saved to: ", file.path(output_dir, output_summary))

if (detailed_diff && length(all_value_diffs) > 0) {
    detailed_diffs_df <- bind_rows(all_value_diffs)
    write_csv(detailed_diffs_df, file.path(output_dir, "detailed_diffs", output_detailed))
    message("Detailed value-level differences saved to: ",
            file.path(output_dir, "detailed_diffs", output_detailed))
} else if (detailed_diff) {
    message("No value-level differences found.")
} else {
    message("Detailed diff disabled — summary only.")
}


