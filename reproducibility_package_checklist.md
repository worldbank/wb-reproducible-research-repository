---
layout: default
title: "Checklist"
---

[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](./index.html)

# Checklist for World Bank Reproducibility Packages

The reproducibility package for World Bank research should include all components in the checklist below.
Authors can request a reproducibility verification [here](https://survey.wb.surveycto.com/collect/prwp_reproducibility?caseid=).
The authors will provide a link to the complete reproducibility package (OneDrive or GitHub),
information on programming language(s), and approximate run time.
Questions should be directed to reproducibility@worldbank.org.

### The reproducibility package includes:

* [ ] A link to the complete reproducibility package on either OneDrive or GitHub. The directory should include all the below components:

  * [ ] **Data**

    * All data files required for reproducibility verification should be included (for verification purposes only; see [here](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/guidance_note_wb.md) for publication guidelines and embargo options for reproducibility packages). The data should be provided in its original form.
    * If the data cannot be shared via OneDrive (e.g., large datasets), please email [reproducibility@worldbank.org](mailto:reproducibility@worldbank.org) to discuss alternatives.

  * [ ] **Code**

    * All code files required to go from the original data to the results in the paper.
    * A main script that allows the reviewer to run all code after changing only the top-level directory. The main script should be in the root directory and should set directory path(s) in one location only. A recommended template is available here: [Stata](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/main.do), [R](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/main.R).
    * If the package does not include a main script, it must have a README that specifies the order of execution of code files.
    * Code should create all exhibits and in-text numerical citations not drawn directly from tables.
    * If the package does not use code and is an Excel package, please review [these guidelines](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/excel/Excel_Guidelines.md).

  * [ ] **README**

    * A README file that guides future readers through the package and how to proceed with replication. A recommended template is available [here](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/README_Template.md).
    * Software and version used
    * Line(s) in the main script that should be changed to run the code on a different machine
    * Approximate run time of the code
    * A map of folder structure
    * Mapping of outputs to scripts responsible for generating them
    * Any specific requests or guidance for the reviewer

  * [ ] **Data Availability Statement** *(can be part of the README file)*

    * List of all datasets used, grouped by access level: *All data publicly available*, *Some data restricted*, *No data publicly available*
    * For each dataset: include filename, source, URL, and access year. Provide a link (if public), or step-by-step instructions on how/where/when a third party can access the data (if restricted or embargoed)
    * Description of any restrictions on data access, publication, or storage/retention periods based on data terms of use
    * Rights statement confirming that the authors had legitimate access to all data used in the manuscript

  * [ ] **Outputs used in the paper** (e.g., tables and figures) in raw form

    * *Optional:* If the manuscript was written in LaTeX and includes `.tex`-generated outputs, include the `.tex` file(s) used to compile the manuscript (e.g., an Overleaf export or equivalent). This allows for easier verification of the alignment between code-generated outputs and the manuscript.

---

### The reproducibility package should **not** include:

* Any code or datasets that are not necessary for the set of results included in the paper (or appendices)
* Any extraneous documentation (such as project notes or internal communication)


[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](./index.html)
