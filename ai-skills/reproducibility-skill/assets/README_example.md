# Gold-standard README example (annotated)

This is a condensed, annotated version of a real README the reproducibility team considers a model, from a package spanning Stata, Julia, Python, and Matlab ("Openness and Productivity Reform: Lessons for Middle-Income Economies from Thailand and other ASEAN", Artuc, Neagu, Taglioni). Annotations in [brackets] explain why each element works. Use it together with `assets/README_template.md`: the template gives the required sections; this example shows the level of specificity to aim for.

---

## Overview

> This package replicates Tables 1 and 2 (descriptive statistics), and Table 6 (simulation results). Tables 3 and 5 are non-numerical tables. Table 4 is taken directly from another research paper (Santoni et al. 2026) and not produced by authors.

[Why this works: it states up front exactly which exhibits the package reproduces AND accounts for every exhibit it does not, each with a reason. A reviewer never has to wonder why Table 4 has no script.]

## List of Exhibits

> - Table 1 → reproduced by `descriptive/code_tables_1_and_2.do` in Stata [find it in `descriptive/descriptive_tables.xls` sheet 1]
> - Table 2 → reproduced by `descriptive/code_tables_1_and_2.do` in Stata [find it in `descriptive/descriptive_tables.xls` sheet 2]
> - Table 3 → non-numerical table
> - Table 4 → taken from Santoni et al 2026
> - Table 5 → non-numerical table
> - Table 6 → reproduced by `simulations/run_all.m` in Matlab after running data processing scripts [find it in `simulations/main_results_table6.csv`]

[Why this works: complete mapping — every exhibit, the exact script, and the exact output file including sheet number. Non-reproducible exhibits are listed, not silently skipped.]

## Data

Each dataset gets its own block. Example:

> **Inter-Country Input-Output Tables (ICIO)**
> - Source: OECD
> - Year: 2025
> - URL: https://www.oecd.org/en/data/datasets/inter-country-input-output-tables.html
> - Access Date: November 2025
> - Note: There are two versions of ICIO: regular and extended. We use the 2025 edition (October 2025 update of regular ICIO), first and latest years available: 1994 and 2022. The January 2026 version is accessible; the October 2025 version is no longer on the website.
> - Citation: OECD. 2025. "Inter-Country Input-Output tables (ICIO)". OECD TiVA database. [dataset].

[Why this works: filename-level precision, access date (data gets updated — the note even warns that the exact vintage used is no longer downloadable, which is honest and exactly what a replicator needs to interpret discrepancies), and a formal dataset citation. A discontinued source (Doing Business) is documented with an explicit note that no comparable alternative exists — a restriction stated, not hidden.]

## Software Requirements

> - StataNow/MP 18.5 for Windows (64-bit x86-64) or StataNow MP/19.5 for MacOS
> - Matlab 2026a
> - Python 3.13.1 with Numpy, SciPy, Pandas, matplotlib and xarray
> - Julia 1.12 with MAT, LinearAlgebra, DataFrames, DelimitedFiles, CSV and Printf
> - Tested on MacBook Pro with M5 Chipset.

[Why this works: versions for every language, package lists per language, and the actual test hardware.]

## Instructions

The package cannot be one-click (four languages), so the README gives an exact ordered recipe, with expected run times:

> **Descriptive Tables**
> 1. Download and store data as follows:
>    - GVC indicators: Download all files except "GVC TRADE data" from <URL>, store in `descriptive/underlying_data_table_1`, unzip all. (Takes less than 5 minutes on the test computer.)
>    - NTM: Go to <URL>, choose Thailand from the dropdown, write down the Coverage Ratio and Frequency Index. Repeat for Indonesia, Malaysia, Philippines, Vietnam, Singapore. Save to Excel file `NTM_data` in `descriptive/underlying_data_table_2`. (Takes less than 5 minutes.)
> 2. Open `code_tables_1_and_2.do` from the `descriptive` folder.
> 3. In the do file, change directory to the descriptive folder.
> 4. Click Run. (Takes less than 1 minute on the Windows test computer.)
> 5. Results are in the two worksheets of `descriptive_tables.xlsx` in the `descriptive` folder.
>
> **Simulations**
> 1. Change directory to `simulations/tiva_2025`.
> 2. Run `data_process_tiva.jl` with Julia. (Takes less than 10 minutes on the test computer.)
> 3. Run `data_process_pwt.py` with Python. (Takes less than 2 minutes.)
> 4. Change directory to `simulations`.
> 5. Run `run_main.m` in Matlab. (Takes less than 10 minutes.)
> 6. The results table is `simulations/main_results_table6.csv`.

[Why this works: every step is a single concrete action with its directory, its language, and its expected run time, so the reviewer knows immediately when something hangs. Even a manual data step (the NTM dropdown lookup) is documented so precisely it is reproducible. The single line to change is identified. This is the acceptable fallback when a true one-click main script is infeasible — but note that even here, a per-language wrapper (one master do-file, one master .m) is used within each stage.]

## Folder Structure

> - `descriptive/`: folder for descriptive statistics
> - `simulations/`: folder for the simulation code
> - `simulations/tiva_2025/tiva_raw_2025/`: folder for raw ICIO files
> - `simulations/tiva_2025/pwt_raw/`: folder for raw PWT files

[Why this works: raw data folders are explicit, so download instructions can point to exact destinations.]
