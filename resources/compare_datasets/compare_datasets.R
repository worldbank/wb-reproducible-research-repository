library(readr)
library(readxl)
library(haven)
library(dplyr)
library(purrr)
library(janitor)
library(waldo)
library(digest)
library(tools)

# Define file paths
pkg_path <- "package"
pub_path <- "public"
output_summary <- "comparison_report.csv"
output_detailed <- "detailed_value_diffs.csv"
dir.create("detailed_diffs", showWarnings = FALSE)

# SHA256 function
calculate_sha256 <- function(filepath) {
    tryCatch({
        digest::digest(file = filepath, algo = "sha256")
    }, error = function(e) {
        NA_character_
    })
}

# Read dataset based on extension
read_dataset <- function(file) {
    ext <- file_ext(file)
    switch(ext,
           csv = read_csv(file, show_col_types = FALSE),
           xlsx = read_excel(file),
           dta = read_dta(file),
           stop("Unsupported format: ", file)
    )
}

# Get list of files by base name
pkg_files <- list.files(pkg_path, full.names = TRUE)
pub_files <- list.files(pub_path, full.names = TRUE)

matched_files <- intersect(
    file_path_sans_ext(basename(pkg_files)),
    file_path_sans_ext(basename(pub_files))
)

# Initialize reports
summary_report <- list()
all_value_diffs <- list()

# Loop through matched files
for (name in matched_files) {
    pkg_file <- pkg_files[basename(file_path_sans_ext(pkg_files)) == name][1]
    pub_file <- pub_files[basename(file_path_sans_ext(pub_files)) == name][1]
    
    # Calculate hashs
    hash_pkg <- calculate_sha256(pkg_file)
    hash_pub <- calculate_sha256(pub_file)
    hash_status <- if (identical(hash_pkg, hash_pub)) {
        "hashs match"
    } else {
        "hashs differ"
    }
    
    # Read data
    pkg_data <- tryCatch(read_dataset(pkg_file), error = function(e) NULL)
    pub_data <- tryCatch(read_dataset(pub_file), error = function(e) NULL)
    if (is.null(pkg_data) || is.null(pub_data)) next
    
    # Clean column names
    pkg_data <- clean_names(pkg_data)
    pub_data <- clean_names(pub_data)
    
    # Compare structure
    vars_pkg <- names(pkg_data)
    vars_pub <- names(pub_data)
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
        paste0("Different number of rows: package = ", nrow(pkg_data),
               ", public = ", nrow(pub_data))
    }
    
    # Compare values
    common_vars <- intersect(vars_pkg, vars_pub)
    value_diffs <- sapply(common_vars, function(v) {
        !identical(pkg_data[[v]], pub_data[[v]])
    })
    value_diff_summary <- if (any(value_diffs)) {
        paste("Different values in:", paste(common_vars[value_diffs], collapse = "; "))
    } else {
        "All common variable values match"
    }
    
    # Save to summary report
    summary_report[[name]] <- list(
        file = name,
        package_ext = file_ext(pkg_file),
        public_ext = file_ext(pub_file),
        hash_pkg = hash_pkg, 
        hash_pub = hash_pub,
        hash_status = hash_status,
        row_match_status = row_match_status,
        vars_in_public_status = vars_in_public_status,
        vars_in_package_status = vars_in_package_status,
        value_diff_summary = value_diff_summary
    )
    
    # Collect value-level differences
    for (var in common_vars[value_diffs]) {
        if (length(pkg_data[[var]]) == length(pub_data[[var]])) {
            diffs <- tibble(
                row = seq_along(pkg_data[[var]]),
                package_value = pkg_data[[var]],
                public_value = pub_data[[var]]
            ) %>%
                filter(package_value != public_value) %>%
                mutate(file = name, variable = var, .before = 1)
            
            all_value_diffs[[paste(name, var, sep = "_")]] <- diffs
        }
    }
}

# Save summary report
summary_df <- bind_rows(summary_report)
write_csv(summary_df, output_summary)
message("Summary report saved to: ", output_summary)

# Save detailed differences
if (length(all_value_diffs) > 0) {
    detailed_diffs_df <- bind_rows(all_value_diffs)
    write_csv(detailed_diffs_df, file.path("detailed_diffs", output_detailed))
    message("Detailed value-level differences saved to: ", output_detailed)
} else {
    message("No value-level differences found.")
}