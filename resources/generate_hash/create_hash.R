library(digest)
library(dplyr)
library(readr)
library(tools)
library(tibble)
library(utils)

# Cross-platform directory chooser
choose_directory <- function() {
    if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
        rstudioapi::selectDirectory(caption = "Select your data folder")
    } else if (requireNamespace("tcltk", quietly = TRUE)) {
        tcltk::tk_choose.dir()
    } else {
        stop("No suitable method for choosing a directory. Please install RStudio or tcltk.")
    }
}

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
data_dir <- choose_directory()

if (is.na(data_dir) || data_dir == "") {
    stop("No directory selected. Exiting.")
}

# Normalize path
data_dir <- normalizePath(data_dir, winslash = "/", mustWork = TRUE)

# Define allowed file extensions
valid_extensions <- c("csv", "xlsx", "dta", "zip", "tif", "shp", "cpg", "dbf", "prj", "sbn", "sbx", "shx", "CSV", "DAT", "dcf")

# Recursively list all valid data files
data_files <- list.files(
    path = data_dir,
    pattern = paste0("\\.(", paste(valid_extensions, collapse = "|"), ")$"),
    full.names = TRUE,
    recursive = TRUE
)

file_times <- file.info(data_files)


# Convert to relative paths
relative_paths <- sub(paste0("^", data_dir, "/?"), "", normalizePath(data_files, winslash = "/"))

# Create a data frame with filename, relative path, hash, and date
hash_df <- tibble(
    filename    = basename(data_files),
    path        = relative_paths,
    sha256sum   = sapply(data_files, calculate_sha256),
    date = Sys.Date(),
    modified    = format(
        as.POSIXct(file_times$mtime, tz = Sys.timezone()),
        tz = Sys.timezone(),
        format = "%Y-%m-%d %H:%M:%S"
    ),
    timezone    = Sys.timezone()
)


# Save output
output_path <- file.path(getwd(), "data_hash_report.csv")
write_csv(hash_df, output_path)

cat("Hash report saved to:\n", output_path, "\n")


