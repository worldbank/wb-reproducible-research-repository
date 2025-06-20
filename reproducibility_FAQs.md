---
layout: default
title: "FAQs"
---

[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](./index.html)
 
# Frequently Asked Questions: Reproducibility Packages

Before diving into the FAQs, we recommend reviewing the [Guidance Note](https://worldbank.github.io/wb-reproducible-research-repository/guidance_note_wb.html) for a comprehensive overview of reproducibility standards and submission expectations.

**Note for World Bank Staff:** For internal FAQs tailored to World Bank researchers—please visit the [internal reproducibility resources page](https://worldbankgroup.sharepoint.com/sites/WBPRWP/SitePages/PublishingPages/FAQs-10262018-142102.aspx).

## Table of Contents

- [General FAQs](#general-faqs)
  - [What are the most common reasons reproducibility checks fail?](#what-are-the-most-common-reasons-reproducibility-checks-fail)
  - [How do I submit a package?](#how-do-i-submit-a-package)
  - [Who can submit a reproducibility package?](#who-can-submit-a-reproducibility-package)
  - [How long does the reproducibility verification process take?](#how-long-does-the-reproducibility-verification-process-take)
  - [How should I organize my package?](#how-should-i-organize-my-package)
  - [What does the reproducibility report contain?](#what-does-the-reproducibility-report-contain)
  - [What if my package uses Excel?](#what-if-my-package-uses-excel)

- [Data-Related Questions](#data-related-questions)
  - [What is the starting point for a reproducibility package?](#what-is-the-starting-point-for-a-reproducibility-package)
  - [Can you do a reproducibility verification if the research relies on confidential and/or proprietary data?](#can-you-do-a-reproducibility-verification-if-the-research-relies-on-confidential-andor-proprietary-data)
  - [How do I document the datasets used in the reproducibility package?](#how-do-i-document-the-datasets-used-in-the-reproducibility-package)

- [Code-Related Questions](#code-related-questions)
  - [How should I organize my code?](#how-should-i-organize-my-code)
  - [What is a main script? How do I create one?](#what-is-a-main-script-how-do-i-create-one)
  - [How do I check if my code is stable?](#how-do-i-check-if-my-code-is-stable)
  - [How do I set up a reproducible environment?](#how-do-i-set-up-a-reproducible-environment)
  - [Do you check if the code is correct?](#do-you-check-if-the-code-is-correct)

- [Documentation-Related Questions](#documentation-related-questions)
  - [What is a README and what should it include?](#what-is-a-readme-and-what-should-it-include)
  - [What is a Data Availability Statement?](#what-is-a-data-availability-statement)


## General FAQs

### What are the most common reasons reproducibility checks fail?

Even well-documented research packages can fail reproducibility checks. Below are the most frequent issues we encounter:

- **Unstable Code (Results change with every run):**  
  Reproducibility requires that the same inputs always produce the same outputs. If tables or figures change between runs, the code is unstable. This often happens due to unsorted merges, random processes without a set seed, or non-unique identifiers used for sorting. Instability makes it impossible to confidently verify findings.
  Most instability issues are solved after setting a random seed in the beginning of the code. Some other issues can occur in Stata, which are explained in [this presentation](https://osf.io/2bxn7).

- **Starts from Intermediate Data:**  
  The package should begin with the original/raw data (see the question below on what is original data for more information). If it starts from partially processed or undocumented intermediate datasets, it becomes unclear how those datasets were constructed, preventing full reproducibility. 

- **Manual Steps Not Documented:**  
  If figures or tables are modified manually (e.g., in Excel) without clear instructions or supporting code, the process is difficult for third parties to follow. All steps used to generate results—even if manual—must be documented clearly in the README or equivalent instructions.

- **Coding Errors:**  
  Broken scripts, incorrect file paths, missing dependencies, or syntax errors can prevent the code from running altogether. Ensure the exact package you are submitting runs through without errors before you submit it. Best practice is to have another research team member (not the primary code author) run the package as well (for example, this helps catch hard-coded filepaths). 

- **Incomplete Version Control or Environment Info:**  
  Failing to specify software versions (e.g., using Stata 18 but only declaring Stata), or not locking Python/R environments (e.g., with `requirements.txt`, `renv.lock`) can cause code to behave differently on other systems. Reproducibility requires knowing exactly what software environment was used. [This presentation](https://osf.io/q7rjt) contains more information on this issue and potential solutions.

- **Manuscript Version Not Aligned with Code:**  
Also known as: the copy-paste problem.  In some cases, the code is up to date but the manuscript is not. Or vice versa—the manuscript reflects newer analyses, but the package reflects an older draft. This creates discrepancies between exhibits and outputs. Always ensure that the final manuscript matches the results generated by the package.


### How do I submit a package?
Authors can request a reproducibility verification through [this submission form](https://survey.wb.surveycto.com/collect/prwp_reproducibility?caseid=).    The package must include all components listed in this [checklist](https://worldbank.github.io/wb-reproducible-research-repository/reproducibility_package_checklist.html).

### Who can submit a reproducibility package?
World Bank staff and consultants are eligible to submit reproducibility packages for verification.

### How long does the reproducibility verification process take?

Authors will receive an initial response within **two business days** of submission, confirming whether the package is complete and ready for review or highlighting any issues that need to be addressed first.

Most packages are reviewed within **two weeks** when only minor or no corrections are needed. The overall timeline may vary depending on the complexity of the analysis and the completeness of the submission. Packages that require significant clarification or additional input from authors may take longer.


### How should I organize my package?

It is  recommended to organize your reproducibility package using a clear and consistent folder structure.  The recommended structure includes:
-   `Data/`:    Include only original input data as described in the README. If the package cannot be run directly from source data (e.g., due to access restrictions), you may also include intermediate data, as long as it is clearly labeled and documented in the README.
-   `Code/`:  All scripts required to take the original data to final outputs. Organizing scripts by task (e.g.,  `cleaning/`,  `analysis/`) is recommended.
-   `Output/`:    Raw outputs generated by the code, such as tables (`.csv`,  `.tex`, `.txt` ) and figures (`.png`,  `.jpg`).
-   **Root directory**:
    
    -   Place the  **main script**  here, which runs all code with minimal setup (e.g., only top-level path change).
        
    -   Include the  **README**  and  **Data Availability Statement**  (can be part of the README).
        
    -   Add the  **final manuscript**  or a link to it.

        
### What does the reproducibility report contain?

- **Certification** that the package is functional, stable, and reproduces the paper’s results exactly  
- **Technical environment details** including operating system, processor, memory, and software version used during verification  
- **Exhibit-by-exhibit status** noting whether each table or figure in the paper was successfully reproduced


### What if my package uses Excel?

While Excel is widely used, reproducibility verification is  much more difficult  when workflows rely on manual steps, hidden formulas, or undocumented edits. Therefore,  we strongly discourage using Excel for critical parts of the analysis  and recommend automating as much of the workflow as possible.

If your package includes Excel files:

-   Avoid manual steps  (e.g., copy-pasting, deleting rows)
-   Use formulas and macros  where appropriate
-   Document all transformations clearly  — either in a separate log file or within the README
-   Explain how outputs were created from Excel files, especially if they appear in the manuscript
    


 [See our Excel guidelines](https://worldbank.github.io/wb-reproducible-research-repository/resources/excel/Excel_Guidelines.html)  for recommended practices and our [presentation on how to produce tables and plots in Stata and R](https://osf.io/ezmsb) for quick instructions on how to build reproducible outputs.

## Data-Related Questions

### What is the starting point for a reproducibility package?
A reproducibility package should begin from documented data sources—often referred to as “source data.” Source data refers to a citable dataset—one that is documented, publicly accessible or archived in a World Bank internal catalog—and serves as the starting point for reproducibility.  A few options include:
-   Unmodified raw data: As originally received, from surveys, administrative systems, or fieldwork, with no changes beyond the removal of personally identifiable information(PII).  
-   Published datasets: Datasets from trusted sources like the Microdata Library, LSMS, DHS, etc.  
-   Official statistics & indicators: Data from sources like the World Development Indicators, national statistics portals, or IMF/WEO
-   Data as it was received from another WB team or an external counterpart, except for the removal of personally identifiable information (see the question below on documenting the data sources for more information).


### Can you do a reproducibility verification if the research relies on confidential and/or proprietary data?

Yes, reproducibility verification is still possible when data access is restricted. We use several strategies depending on the nature of the restriction:

- **Data access for verification only**  
  - The reproducibility team may request temporary access directly from the data provider.  
  - If needed, we can sign a non-disclosure agreement (NDA) to access the data solely for verification purposes.

- **Virtual verification**  
  - The author runs the full package in a secure environment on their machine (e.g., via screen sharing or remote desktop).  
  - The reviewer observes the process and receives the resulting outputs and logs for review.

- **Synthetic data (as a complement to the above)**  
  - Authors provide fake but structurally similar data for the public package.​
  - The reviewer still verifies the package using the actual data, through one of the secure methods above. The public package includes only the synthetic version.

### How do I document the datasets used in the reproducibility package?

All datasets used in the package must be documented in the **Data Availability Statement**. This should include the following information based on the source of the data:

#### 🔹 If using data generated by others:

Authors are expected to provide a **full data citation** for each external dataset used. See the [Social Science Data Editors’ guidance on citing data](https://social-science-data-editors.github.io/template_README/template-README.html) for recommended citation formats.

At minimum, include:
- **Filename(s)**: Exact file name(s) from the source  
- **Source**: Name of the data provider or institution  
- **URL**: Direct download link, if available  
- **Access Date**: Month and year when the data was downloaded  
- **License**: Who can access the data? Can it be redistributed?
- If using a subset of the data (e.g., via point-and-click download):
  - Specify details like time period, units, or variable names extracted (e.g., from WDI)
- If using data manually constructed or collected programmatically (i.e.: using web scraping) from a source on the internet or a report:
  - Specify the instructions on how the data was collected and where it comes from
  - Include all other information mentioned above


#### 🔹 If using data generated by your team:
- Publish the data in one of the following approved data catalogues:
  - [Microdata Library (MDL)](https://microdata.worldbank.org/index.php/home) for survey data
  - [Development Data Hub (DDH)](https://datacatalog.worldbank.org/int/home) for geospatial, administrative, time series, and other data
- Choose appropriate terms of use:
  - Internal, external, open access, or by request only
- Provide a citation or DOI

#### 🔹 If using data shared internally by another World Bank team:
- Indicate:
  - Which World Bank team produced the dataset?
  - Will it be published (e.g., on DDH or MDL)?
  - If not, describe the access process and include a contact person
  - Appropriate citation
  - Version used (especially if the dataset is updated periodically)

**In general, we ask that such datasets be archived in a stable location to ensure the reproducibility package remains accessible over time.**

## Code-Related Questions

### How should I organize my code?
Place all code in a `Code/` folder. Use subfolders for logical tasks or manuscript chapters, e.g.:
- `cleaning/`, `construction/`, `analysis/`  
- or `chapter1/`, `chapter2/`, etc.

### What is a main script? How do I create one?
A main script is a single entry point that runs all other scripts in the correct order. It should require only one change: setting the top-level directory, so that anyone can reproduce the full workflow with minimal setup.
-   A recommended template is available here: [Stata](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/main.do), [R](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/main.R).

### How do I check if my code is stable?
**Stable code**  produces the same outputs every time it is run with the same inputs.  **Unstable code**  yields different results on repeated runs, which undermines reproducibility.

**How to test for stability:**  
Run the full code twice. If any outputs differ between runs, the code is unstable.

**How to track output changes:**
To facilitate version control and comparison:
-   Export **figures** in standardized formats such as `.png` or `.jpg` 
-   Save  **tables**  in  `.csv`,  `.txt`, or  `.tex`
-   Use  **Git**  to version-control your outputs and detect changes across runs
    

**Common causes of instability:**

-   Sorting on non-unique ID variables before creating or dropping observations/variables
-   Not setting a seed for random number generation
-   Using different versions of the Statistical software
-   Using  `m:m`  merges
-   Running different versions of user-written packages
    
Ensuring code stability is a key step in creating reproducible research.

### How do I set up a reproducible environment?

A  **reproducible environment**  ensures that anyone running your code has the same setup: software versions, packages, and dependencies, so the results remain consistent over time and across machines.

To set this up, follow the environment setup guides for each language:
-   **Python Environment Setup:**  [Python Instructions](https://worldbank.github.io/wb-reproducible-research-repository/resources/environment-instructions/python.html)
-   **R Environment Setup:**  [R Instructions](https://worldbank.github.io/wb-reproducible-research-repository/resources/environment-instructions/R.html)
-   **Stata Environment Setup:**  [Stata Instructions](https://worldbank.github.io/wb-reproducible-research-repository/resources/environment-instructions/stata.html)

Using a clean, well-defined environment is critical to computational reproducibility.

### Do you check if the code is correct?
No. We only verify complete documentation and **computational reproducibility**: whether running the same code and data produces the same outputs.  We do not assess whether the code correctly implements the intended methods, nor the quality of the code.

## Documentation-Related Questions

### What is a README and what should it include?

A **README** is the main guide to your reproducibility package. It helps others—including reviewers, editors, and future researchers—understand how to navigate, run, and evaluate your code and data. A clear and complete README is essential for transparency and reproducibility.

If your publication is a **journal article**, we recommend using the [Social Science Data Editors' README template](https://social-science-data-editors.github.io/template_README/), which is the standard for many economics journals.

For internal use or working papers, you may use our simplified [README template](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/README_Template.md), which is based on the Social Science Data Editors’ version.


At a minimum, your README should include:

-   **How to run the code**  
    Step-by-step instructions on running the main script. Indicate where the user should set the top-level directory and how to execute the full workflow.
    
-    **File and folder structure**  
    Describe the purpose of each folder (e.g.,  `Data`,  `Code`,  `Outputs`) and what each script does (e.g., cleaning, analysis, visualization).
    
 -    **Data Availability Statement**     
	See more details below. 
    
-   **Run time and Computational Requirements**  
    Give an estimate of how long the package takes andspecify operating system requirements, software dependencies, environment setup instructions, and any other relevant information essential for replicating the results.
    
-   **List of exhibits and linkage table**  
    Clearly identify each table and figure from the manuscript. If the file names differ from the exhibit numbers, include a mapping that links file names to exhibit labels (e.g.,  `Table2_results.csv`  → Table 2 in paper). This helps reviewers locate and verify outputs.

### What is a Data Availability Statement?

A  **Data Availability Statement (DAS)**  explains where and how the data used in a study can be accessed, and under what conditions. It is a critical component of reproducible research, as replication requires access to the exact datasets used in the analysis.

The DAS can be included as a section within the README file and should contain the following:

-  **Categorize the datasets used**, based on their accessibility:  All data are publicly available; Some data cannot be made publicly available; No data can be made publicly available
        
-   **Describe each data source**:  See more under **"How do I document the datasets used in the reproducibility package?"**
        
-   **Include a rights and permissions statement**:  Confirm that the authors had legitimate access to the data and, where applicable, that permission has been granted to redistribute it. If redistribution is not allowed, explain the terms of use or link to the data’s license.


[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](./index.html)

