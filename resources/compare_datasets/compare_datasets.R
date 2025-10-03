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
output_summary <- "comparison_report.csv"
output_detailed <- "detailed_value_diffs.csv"
detailed_diff <- TRUE # <--- SET THIS TO TRUE if you want detailed diffs
dir.create("detailed_diffs", showWarnings = FALSE)

# === FUNCTIONS ===
calculate_sha256 <- function(filepath) {
    tryCatch(digest::digest(file = filepath, algo = "sha256"), error = function(e) NA_character_)
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
pkg_files <- pkg_files[pkg_files != 'package/README.md']
pub_files <- pub_files[pub_files != 'public/README.md']

matched_files <- intersect(
    file_path_sans_ext(tolower(basename(pkg_files))),
    file_path_sans_ext(tolower(basename(pub_files)))
)

summary_report <- list()
all_value_diffs <- list()

# === LOOP THROUGH MATCHED FILES ===
for (name in matched_files) {
    pkg_file <- pkg_files[tolower(basename(file_path_sans_ext(pkg_files))) == name][1]
    pub_file <- pub_files[tolower(basename(file_path_sans_ext(pub_files))) == name][1]
    
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
        
        value_diff_vars <- c()
        type_mismatch_vars <- c()
        
        for (var in common_vars) {
            pkg_col <- pkg_data[[var]]
            pub_col <- pub_data[[var]]
            
            type_pkg <- typeof(pkg_col)
            type_pub <- typeof(pub_col)
            type_mismatch <- !identical(type_pkg, type_pub)
            
            # Trim to equal length
            n <- min(length(pkg_col), length(pub_col))
            pkg_trimmed <- format(pkg_col[1:n])
            pub_trimmed <- format(pub_col[1:n])
            
            diffs <- tibble(
                row = 1:n,
                package_value = pkg_trimmed,
                public_value = pub_trimmed
            ) %>%
                filter(package_value != public_value & !(is.na(package_value) & is.na(public_value))) %>%
                mutate(
                    file = name,
                    variable = var,
                    type_package = type_pkg,
                    type_public = type_pub,
                    type_mismatch = ifelse(type_mismatch, "yes", "no"),
                    .before = 1
                )
            
            if (nrow(diffs) > 0) {
                value_diff_vars <- c(value_diff_vars, var)
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
        } else {
            "All common variable values match"
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
        vars_in_public_status = vars_in_public_status,
        vars_in_package_status = vars_in_package_status,
        value_diff_summary = value_diff_summary,
        type_diff_summary = type_diff_summary
    )
}

# === EXPORT REPORTS ===
summary_df <- bind_rows(summary_report)
write_csv(summary_df, output_summary)
message("Summary report saved to: ", output_summary)

if (detailed_diff && length(all_value_diffs) > 0) {
    detailed_diffs_df <- bind_rows(all_value_diffs)
    write_csv(detailed_diffs_df, file.path("detailed_diffs", output_detailed))
    message("Detailed value-level differences saved to: ", file.path("detailed_diffs", output_detailed))
} else if (detailed_diff) {
    message("No value-level differences found.")
} else {
    message("Detailed diff disabled — summary only.")
}


