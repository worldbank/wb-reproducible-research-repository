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

  * [ ] **Data**

    * All data files required for reproducibility verification should be included (for verification purposes only; see [publication guidelines and embargo options](https://worldbank.github.io/wb-reproducible-research-repository/guidance_note_wb.html)). **The reproducibility package must start from documented data**. For traceability, the reproducibility package is expected to start from original (unprocessed) data. See [FAQ: What is the starting point for a reproducibility package?](https://worldbank.github.io/wb-reproducible-research-repository/reproducibility_FAQs.html#what-is-the-starting-point-for-a-reproducibility-package)).
    * If access is restricted to any input dataset, the dataset(s) should not be included in the original submission. Data can shared after an NDA is signed, or in the case of v[virtual reproducibility verification](https://worldbank.github.io/wb-reproducible-research-repository/guidance/virtual_reproducibility_verification_protocol.html). data is never shared directly with the reproducibility team.  that requires a non-disclosure agreement, strictly confidential data). For questions on tailored pathways, please email [reproducibility@worldbank.org](mailto:reproducibility@worldbank.org).
    * If the input data is very large, the package may start from “usable data” (a fully documented, citable intermediate dataset) provided the README includes (i) provenance and access instructions for raw sources, and (ii) scripts or written protocols that reproduce the usable dataset when access is granted.
    * 

  * [ ] **Code**

    * All code files required to go from the original data to the results in the paper.
    * A main script that allows the reviewer to run all code after changing only the top-level directory. A recommended template is available here: [Stata](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/main.do), [R](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/main.R).
    * If the package does not include a main script, it must have a README that specifies the order of execution of code files.
    * Code should create all exhibits and in-text numerical citations not drawn directly from tables.
    * If the package does not use code and is an Excel package, please review [these guidelines](https://worldbank.github.io/wb-reproducible-research-repository/resources/excel/Excel_Guidelines.html).
    * If applicable, the author may submit (i) build instructions and compiler versions, or (ii) a container image, or (iii) deterministic binaries plus environment details. If source cannot be shared immediately, indicate source-escrow terms (e.g., released at journal acceptance or after embargo).

  * [ ] **README**

    * A README file that guides future readers through the package and how to proceed with replication.  
  A recommended template is available [here](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/README_Template.md), and you can also use our [README generator](https://dime-worldbank.github.io/wb-reproducible-research-repository-automation/).
    * Software and version used
    * Line(s) in the main script that should be changed to run the code on a different machine
    * Mapping of outputs to scripts responsible for generating them
    * Any specific requests or guidance for the reviewer

  * [ ] **Data Availability Statement** *(can be part of the README file)*

    * Summary of availability for the data used: *All data publicly available*, *Some data restricted*, *No data publicly available*
    * For each dataset: include filename, source, URL, and access year. Provide a link (if public), or step-by-step instructions on how/where/when a third party can access the data (if restricted or embargoed)
    * Description of any restrictions on data access, publication, or storage/retention periods based on data terms of use
    * Rights statement confirming that the authors had legitimate access to all data used in the manuscript
      
    See our [FAQ](https://worldbank.github.io/wb-reproducible-research-repository/reproducibility_FAQs.html#how-do-i-document-the-datasets-used-in-the-reproducibility-package) for guidance on documenting different types of datasets.

  * [ ] **Outputs used in the paper** (e.g., tables and figures) in raw form
* In the case of very large datasets, or simulations of large models (compute time >5 days), authors may select the Artifact Pathway. In this case, authors will provide pre-computed outputs (tables/figures and intermediate artifacts) accompanied by code and SHA256 checksums to enable integrity checks.

  * [ ] **Manuscript**  
  
    * Please include the **final manuscript** that will be used for publication. This is the version we will use to review exhibits one by one.  
    * Make sure this is the definitive version and that it is updated to reflect the **final version of the code**, as approximately 35% of reproducibility failures stem from version control issues.

---

### The reproducibility package should **not** include:

* Any code or datasets that are not necessary for the set of results included in the paper (or appendices)
* Any extraneous documentation (such as project notes or internal communication)


[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](./index.html)
