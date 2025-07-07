library(digest)
library(dplyr)
library(readr)
library(tools)
library(tibble)
library(rstudioapi)
library(utils)

# Function to calculate SHA256 hash of a file
calculate_sha256 <- function(filepath) {
    tryCatch({
        digest::digest(file = filepath, algo = "sha256", serialize = FALSE)
    }, error = function(e) {
        NA_character_
    })
}

# Ask user to select the working directory
cat("Please select the directory where your data files are stored:\n")
data_dir <- choose.dir()

if (is.na(data_dir)) {
    stop("No directory selected. Exiting.")
}

# Normalize path
data_dir <- normalizePath(data_dir, winslash = "/", mustWork = TRUE)

# Define allowed file extensions
valid_extensions <- c("csv", "xlsx", "dta")

# Recursively list all valid data files
data_files <- list.files(
    path = data_dir,
    pattern = paste0("\\.(", paste(valid_extensions, collapse = "|"), ")$"),
    full.names = TRUE,
    recursive = TRUE
)

# Convert to relative paths
relative_paths <- sub(paste0("^", data_dir, "/?"), "", normalizePath(data_files, winslash = "/"))

# Create a data frame with filename, relative path, hash, and date
hash_df <- tibble(
    filename = basename(data_files),
    path = relative_paths,
    sha256sum = sapply(data_files, calculate_sha256),
    date = Sys.Date()
)

# Save output
output_path <- file.path("data_hash_report.csv")
write_csv(hash_df, output_path)

cat("Hash report saved to:\n", output_path, "\n")
