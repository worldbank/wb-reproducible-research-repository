# 🔐 Dataset Hash Generator

This tool calculates **SHA256 hashes** for all datasets (such as `.csv`, `.xlsx`, and `.dta` files) located in a specified folder (and its subfolders). It is designed to support reproducibility by documenting the exact version of data files used in a project.

---

## 🧭 What This Script Does

- Recursively scans a selected folder and its subfolders (e.g., `data/`, or `data/deidentified`)
- Identifies data files with relevant extensions (such as `.csv`, `.xlsx`, and `.dta` files)
- Calculates the **SHA256 hash** of each file
- Records:
  - Filename
  - Relative path (within the selected folder)
  - SHA256 hash
  - Date of hash generation
  - Date the data was modified
- Exports the result as `data_hash_report.csv` in the root of the current R project

---

## 📦 Typical Use Case

This script is useful in **reproducibility packages**, where verifying the integrity and exact identity of datasets is critical.

You can run it on any folder (e.g., `data/`) before sharing or archiving a reproducibility package. The resulting `data_hash_report.csv` file can be included in the final publication to:

- Track which datasets were used
- Detect changes over time
- Ensure full transparency and traceability

---

## 🛠️ How to Use

1. Open the Rproject.
2. Update line 40 to add any file extensions not already listed (the script includes `.csv`, `.xlsx`, and `.dta` by default).
3. Run the script (`hash_generator.R`) in your session.
4. When prompted, select the folder where your datasets are stored.
5. Wait a few seconds while the script scans and processes your files.
6. After completion, a file named `data_hash_report.csv` will be created in the **R project root folder**.

---

## 📋 Output Example

When you run the script, it creates a file called `data_hash_report.csv` that looks like this:

| filename             | path                           | sha256sum     | date       | modified        | timezone         |
|----------------------|--------------------------------|---------------|------------|-----------------|------------------|
| baseline_i.dta       | baseline_i.dta                 | 8a7f7e7c1b... | 2025-06-30 | 6/30/2025 20:26 | America/New_York |
| midline_hh_clean.csv | subfolder/midline_hh_clean.csv | 3e2bfaf3c1... | 2025-06-30 | 6/22/2025 16:00 | America/New_York |

- **filename**: Name of the dataset file
- **path**: Relative path within the selected folder
- **sha256sum**: The SHA256 hash of the file
- **date**: Date when the hash was generated
- **modified**: The date and time the file was last modified. This is useful to differentiate between raw data and data that was updated after running the code.
- **timezone**: The timezone

---

## 📁 Folder Structure and Files

A standard reproducibility package that includes this hash tool might look like the following:

```
RR_WLD_2025_400/
├── LICENSE.txt
├── WB-IGO-RIDER.txt
├── README.pdf
├── reproducibility_report_RR_WLD_2025_400.pdf
├── data_hash_report.csv       # 🔐 Output of this script
├── reproducibility package/
```

---

## 🔗 Acknowledgment

The SHA256 calculation method used in this tool is based on code from:
**[Day 1 Tutorial (ASSA 2025)](https://github.com/larsvilhuber/day1-tutorial/blob/main/checksums.R)**  
By Lars Vilhuber
