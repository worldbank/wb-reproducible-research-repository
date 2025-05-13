# 🔍 Dataset Comparison and Reproducibility Verification Tool

This tool helps verify whether two versions of the same dataset—typically one shared privately by the authors (`package/`) and one accessible externally (`public/`)—are identical in structure, content, and checksum. It is primarily used by the PRWP Reproducibility Verification team.

---

## 📦 Folder Structure

Place your datasets in the following folder structure:

```
project-folder/
├── package/     # Datasets shared by authors
├── public/      # Public or accessible datasets
├── comparison_report.csv
├── detailed_value_diffs.csv (if needed)
└── compare_datasets.R   # The script
```

### ⚠️ Naming Requirement
Files must have the **same name** (excluding extension) to be matched. For example:

```
package/Ghana-2022-ISES-full-data.dta
public/Ghana-2022-ISES-full-data.dta
```

Supported formats:

- `.dta` (Stata)
- `.csv` (Comma-separated)
- `.xlsx` (Excel)

---

## 🛠️ How to Use

1. Clone or download this repository.  
2. Open the R project file (`review.Rproj`).
3. Place datasets in their corresponding folders:
   - **`package/`**: the file received from authors.
   - **`public/`**: the public equivalent.
4. Make sure file names match (excluding extension).
5. Install the required packages:
   - Run `renv::restore()` (if using `renv`) or manually install the packages listed in the `renv.lock` file.
6. Run the `compare_datasets.R` script from RStudio.

---

## 📋 Output Files

### 1. `comparison_report.csv` (Summary Report)

This file provides a side-by-side summary comparison of each matched dataset. It includes:

| Column                      | Description                                                                 |
|-----------------------------|-----------------------------------------------------------------------------|
| `file`                      | Base filename used for comparison                                           |
| `package_ext`, `public_ext`| File formats (.dta, .csv, etc.)                                             |
| `hash_pkg`, `hash_pub`     | SHA256 hashes to verify file integrity                                      |
| `hash_status`              | Whether the hashes match                                                    |
| `row_match_status`         | Whether the datasets have the same number of rows                          |
| `vars_in_public_status`    | Whether all variables in the public file exist in the package file         |
| `vars_in_package_status`   | Whether all variables in the package file exist in the public file         |
| `value_diff_summary`       | Which variables contain differing values (if any)                          |


#### ✅ Example Output

| file     | checksum_status | row_match_status    | value_diff_summary               |
|----------|------------------|---------------------|----------------------------------|
| Ghana-2022-ISES-full-data | Checksums match  | Same number of rows  | All common variable values match |
| P_Data_Extract_From_WDI_Database_Archives | Checksums differ | Same number of rows | Different values in: x2022_yr2022 |

---

### 2. `detailed_value_diffs.csv` (Detailed Value-Level Differences)

This file is generated **only when differences in values** are found between matched datasets.

It lists every differing value **row by row**, including:

| Column          | Description                                 |
|------------------|---------------------------------------------|
| `file`          | Dataset name                                |
| `variable`      | Name of the variable with differences       |
| `row`           | Row number of the difference                |
| `package_value` | Value in the author's version               |
| `public_value`  | Value in the public version                 |

#### ✅ Example Rows from `detailed_value_diffs.csv`

| file     | variable        | row | package_value | public_value |
|----------|------------------|-----|----------------|----------------|
| P_Data_Extract_From_WDI_Database_Archives | x2022_yr2022 | 12  | 13.5           | 14.2           |
| P_Data_Extract_From_WDI_Database_Archives | x2022_yr2022 | 107 | 10.0           | 9.6            |

---

## ✅ Checklist Before Running

- [ ] Ensure R and required libraries (`readr`, `readxl`, `haven`, `janitor`, `digest`, `waldo`, `tools`, `dplyr`) are installed.
- [ ] Place the datasets in `package/` and `public/`.
- [ ] Ensure file names match across folders.

---

## 👩🏽‍💻 Intended Audience

This tool is primarily intended for **reproducibility reviewers** working with the PRWP Reproducibility Initiative. It helps verify that the datasets shared by authors match those that are publicly available or externally accessible.

Researchers and authors can also use this tool to confirm that the dataset used in their analysis aligns with the version currently published or publicly available. This is especially useful when datasets may have been updated or revised over time. The tool highlights both exact matches and meaningful differences, making it a valuable resource for quality control and transparency.

---

## 📬 Questions or Issues?

If you encounter errors or want to extend the tool for new formats or checks, please contact the PRWP reproducibility team (reproducibility@worldbank.org).
