*===============================================================================
* Data inventory — for code-only mode (SKILL.md, Phase 0)
*
* Run this on YOUR OWN machine. It lists every data file under a folder and
* records file-level metadata only:
*   filename, relative path, SHA256 hash, size, and (for .dta, .csv, .tsv,
*   .xlsx, .xls) variable/column names and Excel sheet names.
* It never records data values, value labels, variable labels, or summary
* statistics. Open data_inventory.csv and review it before sharing it with
* the AI agent.
*
* The empty columns at the end (source, url, access_date, license,
* availability, notes) are for you to fill in for each dataset you did not
* create yourself. They become the Data Availability Statement in the README.
* Leave them blank for files your own code produces.
*
* Hashing follows resources/generate_hash in this repository.
* Requires Stata 14 or later.
*===============================================================================

clear all
set more off

*--- 1. CHANGE THESE -----------------------------------------------------------
global data_dir ""   // folder that holds the project's data, e.g. "C:/myproject/data"
global out_dir  ""   // folder where data_inventory.csv is saved -- somewhere the AI agent
                     // CAN read, outside the data folder, e.g. "C:/myproject-code"
local include_varnames 1   // set to 0 if variable names themselves are sensitive

*--- 2. Packages ---------------------------------------------------------------
cap which filelist
if _rc ssc install filelist
cap which shasum
if _rc net install shasum, from("https://raw.githubusercontent.com/mcaceresb/stata-shasum/master/build")

if `"$data_dir"' == "" | `"$out_dir"' == "" {
    di as error "Set data_dir and out_dir at the top of the script."
    exit 198
}
local root = subinstr(`"$data_dir"', "\", "/", .)
if substr("`root'", -1, 1) == "/" local root = substr("`root'", 1, strlen("`root'") - 1)

*--- 3. List data files --------------------------------------------------------
filelist, dir("`root'")
replace dirname = subinstr(dirname, "\", "/", .)
gen extension = lower(substr(filename, strrpos(filename, ".") + 1, .)) if strrpos(filename, ".") > 0
local data_exts dta sav csv tsv txt xlsx xls rds rdata rda parquet feather json shp dbf gpkg geojson tif zip gz
gen byte is_data = 0
foreach x of local data_exts {
    replace is_data = 1 if extension == "`x'"
}
keep if is_data
drop is_data

if _N == 0 {
    di as error "No data files found under `root'."
    exit 601
}

*--- 4. Hashes -----------------------------------------------------------------
replace dirname = dirname + "/"
shasum dirname filename, sha256(sha256sum) filelist

*--- 5. Structure only: variable names and sheet names, never values -----------
local N = _N
forvalues i = 1/`N' {
    local f`i' = dirname[`i'] + filename[`i']
    local e`i' = extension[`i']
}
tempfile files
save `files'

forvalues i = 1/`N' {
    local f "`f`i''"
    local e "`e`i''"

    if "`e'" == "dta" {
        * describe using reads the header only; the data are not loaded
        cap describe using "`f'", varlist
        if !_rc {
            local nv`i' = r(k)
            local vl`i' "`r(varlist)'"
        }
    }
    else if inlist("`e'", "csv", "tsv") {
        local delim = cond("`e'" == "tsv", "\t", ",")
        cap import delimited using "`f'", varnames(1) rowrange(1:2) delimiters("`delim'") clear
        if !_rc {
            local nv`i' = c(k)
            qui ds
            local vl`i' "`r(varlist)'"
        }
    }
    else if inlist("`e'", "xlsx", "xls") {
        cap import excel using "`f'", describe
        if !_rc {
            local ns = r(N_worksheet)
            local sheet1 `"`r(worksheet_1)'"'
            local range1 "`r(range_1)'"
            local sh ""
            forvalues s = 1/`ns' {
                local sh `"`sh'`=cond(`s' > 1, " | ", "")'`r(worksheet_`s')'"'
            }
            local sh`i' `"`sh'"'
            * header row of the first sheet only
            if "`range1'" != "" {
                local ul = substr("`range1'", 1, strpos("`range1'", ":") - 1)
                local lr = substr("`range1'", strpos("`range1'", ":") + 1, .)
                local lastcol = ustrregexra("`lr'", "[0-9]+", "")
                local firstrow = real(ustrregexra("`ul'", "[A-Z]+", ""))
                cap import excel using "`f'", sheet(`"`sheet1'"') ///
                    cellrange(`ul':`lastcol'`=`firstrow' + 1') firstrow allstring clear
                if !_rc {
                    local nv`i' = c(k)
                    qui ds
                    local vl`i' "`r(varlist)'"
                }
            }
        }
    }
}

*--- 6. Build and save the report ----------------------------------------------
use `files', clear
gen long n_vars = .
gen strL sheets = ""
gen strL variables = ""
forvalues i = 1/`N' {
    if "`nv`i''" != "" replace n_vars = `nv`i'' in `i'
    replace sheets = `"`sh`i''"' in `i'
    if `include_varnames' replace variables = "`vl`i''" in `i'
}

gen path = substr(dirname, strlen("`root'") + 2, .) + filename
gen date = string(today(), "%tdCCYY-NN-DD")
gen modified = ""   // Stata cannot read file modification times; see data_inventory.R
rename fsize size_bytes

* to fill in by the author (external inputs only)
foreach v in source url access_date license availability notes {
    gen `v' = ""
}
* availability: public / restricted / forthcoming

keep  filename path sha256sum date modified extension size_bytes n_vars sheets variables ///
      source url access_date license availability notes
order filename path sha256sum date modified extension size_bytes n_vars sheets variables ///
      source url access_date license availability notes

local out_file "$out_dir/data_inventory.csv"
export delimited using `"`out_file'"', replace
di as result "Data inventory saved to: `out_file'"
di as result "Review it before sharing: it should contain no data values."
