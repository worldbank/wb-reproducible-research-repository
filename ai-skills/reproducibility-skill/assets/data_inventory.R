# ==============================================================================
# Data inventory — for code-only mode (SKILL.md, Phase 0)
#
# Run this on YOUR OWN machine. It lists every data file under a folder and
# records file-level metadata only:
#   filename, relative path, SHA256 hash, size, last-modified date, and
#   (for .dta, .sav, .csv, .tsv, .rds, .xlsx, .xls) variable/column names
#   and Excel sheet names.
# It never records data values, value labels, variable labels, or summary
# statistics. Open data_inventory.csv and review it before sharing it with
# the AI agent.
#
# The empty columns at the end (source, url, access_date, license,
# availability, notes) are for you to fill in for each dataset you did not
# create yourself. They become the Data Availability Statement in the README.
# Leave them blank for files your own code produces.
#
# Hashing follows resources/generate_hash in this repository.
# ==============================================================================

# ------------------------------------------------------------------
# 1. CHANGE THESE
# ------------------------------------------------------------------
data_dir <- ""   # folder that holds the project's data, e.g. "C:/myproject/data"
out_dir  <- ""   # folder where data_inventory.csv is saved -- somewhere the AI agent
                 # CAN read, outside the data folder, e.g. "C:/myproject-code"
include_varnames <- TRUE   # set to FALSE if variable names themselves are sensitive

# ------------------------------------------------------------------
# 2. Packages
# ------------------------------------------------------------------
pkgs <- c("digest", "haven", "readxl")
to_install <- pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)]
if (length(to_install)) install.packages(to_install)

if (data_dir == "" || out_dir == "") stop("Set data_dir and out_dir at the top of the script.")
out_file <- file.path(out_dir, "data_inventory.csv")
data_dir <- normalizePath(data_dir, winslash = "/", mustWork = TRUE)

# ------------------------------------------------------------------
# 3. List data files
# ------------------------------------------------------------------
data_exts <- c("dta", "sav", "csv", "tsv", "txt", "xlsx", "xls", "rds", "rdata", "rda",
               "parquet", "feather", "json", "shp", "dbf", "gpkg", "geojson", "tif", "zip", "gz")

files <- list.files(data_dir, recursive = TRUE, full.names = TRUE)
files <- normalizePath(files, winslash = "/")
ext   <- tolower(tools::file_ext(files))
keep  <- ext %in% data_exts
files <- files[keep]
ext   <- ext[keep]

# ------------------------------------------------------------------
# 4. Structure only: variable names and sheet names, never values
# ------------------------------------------------------------------
describe_file <- function(f, e) {
  sheets <- ""
  vars <- tryCatch({
    if (e == "dta") {
      names(haven::read_dta(f, n_max = 0))
    } else if (e == "sav") {
      names(haven::read_sav(f, n_max = 0))
    } else if (e %in% c("csv", "tsv")) {
      names(utils::read.csv(f, nrows = 0, sep = if (e == "tsv") "\t" else ",",
                            check.names = FALSE))
    } else if (e == "rds") {
      obj <- readRDS(f)
      if (is.data.frame(obj)) names(obj) else NULL
    } else if (e %in% c("xlsx", "xls")) {
      sh <- readxl::excel_sheets(f)
      sheets <- paste(sh, collapse = " | ")
      names(readxl::read_excel(f, sheet = 1, n_max = 0))   # header row of first sheet
    } else {
      NULL
    }
  }, error = function(err) NULL)

  list(
    n_vars    = if (is.null(vars)) NA_integer_ else length(vars),
    sheets    = sheets,
    variables = if (is.null(vars) || !include_varnames) "" else paste(vars, collapse = " ")
  )
}

info <- lapply(seq_along(files), function(i) describe_file(files[i], ext[i]))

# ------------------------------------------------------------------
# 5. Build and save the report
# ------------------------------------------------------------------
inventory <- data.frame(
  filename     = basename(files),
  path         = substring(files, nchar(data_dir) + 2),
  sha256sum    = vapply(files, function(f) digest::digest(file = f, algo = "sha256"),
                        character(1), USE.NAMES = FALSE),
  date         = format(Sys.Date(), "%Y-%m-%d"),
  modified     = format(file.info(files)$mtime, "%Y-%m-%d %H:%M:%S"),
  extension    = ext,
  size_bytes   = file.info(files)$size,
  n_vars       = vapply(info, `[[`, integer(1), "n_vars"),
  sheets       = vapply(info, `[[`, character(1), "sheets"),
  variables    = vapply(info, `[[`, character(1), "variables"),
  # --- to fill in by the author (external inputs only) ---
  source       = "",
  url          = "",
  access_date  = "",
  license      = "",
  availability = "",   # public / restricted / forthcoming
  notes        = "",
  stringsAsFactors = FALSE
)

utils::write.csv(inventory, out_file, row.names = FALSE, na = "")
cat("Data inventory saved to:", out_file, "\n",
    "Review it before sharing: it should contain no data values.\n")
