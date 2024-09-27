### Main R Script Template

# Load libraries ----
# Add any additional libraries as needed for your project.
# Tip: for best practice you can also use the renv package to manage dependencies (https://rstudio.github.io/renv/articles/renv.html), but this is not strictly needed.

# library(haven)        # For reading .dta files
# library(dplyr)        # For data manipulation
# library(tidyr)        # For reshaping data

# You can add or remove packages as necessary for your specific project.

# Set package path ----

# This is the root directory where your files are stored.
# Replace "your/path/to/package" with the actual path to your package.

path <- "your/path/to/package/"

# Example of what path might look like on different systems:
# path <- "C:/Users/username/Documents/Project/"   # For Windows
# path <- "/Users/username/Documents/Project/"     # For Mac or Linux

# Note: It's recommended to avoid hardcoding paths and instead use relative paths when possible,
# especially when sharing scripts or working in teams.

# Run the R scripts ----
# Source the scripts that are part of your project.
# Modify the filenames as needed to match your project structure.
# Ensure that the paths to these scripts are correct.

source(file.path(path, "Code/01-processing-data.R"))
source(file.path(path, "Code/02-constructing-data.R"))
source(file.path(path, "Code/03-analyzing-data.R"))


# Notes:
# - This template assumes that the project has a directory structure where scripts are in a "Code" folder.
# - The `file.path()` function creates platform-independent paths.
# - Ensure that each script referenced here can run independently and is well-documented.


