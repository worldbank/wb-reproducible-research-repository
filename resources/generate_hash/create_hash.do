*===============================================================================
* Description: This script generates a list of specified file types from a 
*              directory and its subdirectories with their SHA256 hashes
*
* Steps:
*   1. Clears the current dataset.
*   2. Sets a global macro for the target directory.
*   3. Uses the `rdir` command to recursively list all files.
*   4. Extracts the file extension from each filename.
*   5. Filters the list to keep only the relevant file extensions
*   6. Generates the file hashes
*   7. Exports the results to a CSV file.
*===============================================================================

clear
set more off

capture ssc install filelist
capture net install shasum, from(https://raw.githubusercontent.com/mcaceresb/stata-shasum/master/build)

*1. Define the root directory to search
*   Replace with the actual path to your folder.
global root_dir ""


*2. Get a list of all files in the directory and its subdirectories
cd "$root_dir"
filelist
drop fsize

*3. Generate a variable with the file extension
gen file_extension = ""
replace file_extension = substr(filename, strrpos(filename, ".") + 1, .) if strrpos(filename, ".") > 0
replace file_extension = lower(file_extension)

*4. Keep only observations for specified file types
keep if inlist(file_extension, "dta", "csv", "xlsx", "xls", "shp", "sav", "zip") // add other types if needed

*5. Generate hashes
replace dirname = dirname + "/"
shasum dirname filename, sha256(sha256sum) filelist

*6. Same order of columns and names as it's done in the R script
drop file_extension
rename dirname path
order filename path sha256sum
gen date = today()
format date %td

*7. Export
compress _all
export delimited using "data_hash_report.csv", replace
