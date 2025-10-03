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

    * All data files required for reproducibility verification should be included (for verification purposes only; see [publication guidelines and embargo options](https://worldbank.github.io/wb-reproducible-research-repository/guidance_note_wb.html)). **The data should be provided in its original form** (see [FAQ: What is the starting point for a reproducibility package?](https://worldbank.github.io/wb-reproducible-research-repository/reproducibility_FAQs.html#what-is-the-starting-point-for-a-reproducibility-package)).
    * If the data cannot be shared via OneDrive (e.g., large datasets, data that requires a non-disclosure agreement, strictly confidential data), please email [reproducibility@worldbank.org](mailto:reproducibility@worldbank.org) to discuss alternatives. Options include signing an NDA or conducting a [virtual reproducibility verification](https://worldbank.github.io/wb-reproducible-research-repository/guidance/virtual_reproducibility_verification_protocol.html).

  * [ ] **Code**

    * All code files required to go from the original data to the results in the paper.
    * A main script that allows the reviewer to run all code after changing only the top-level directory. A recommended template is available here: [Stata](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/main.do), [R](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/main.R).
    * If the package does not include a main script, it must have a README that specifies the order of execution of code files.
    * Code should create all exhibits and in-text numerical citations not drawn directly from tables.
    * If the package does not use code and is an Excel package, please review [these guidelines](https://worldbank.github.io/wb-reproducible-research-repository/resources/excel/Excel_Guidelines.html).

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
  
  * [ ] **Manuscript**  
  
    * Please include the **final manuscript** that will be used for publication. This is the version we will use to review exhibits one by one.  
    * Make sure this is the definitive version and that it is updated to reflect the **final version of the code**, as approximately 35% of reproducibility failures stem from version control issues.

---

### The reproducibility package should **not** include:

* Any code or datasets that are not necessary for the set of results included in the paper (or appendices)
* Any extraneous documentation (such as project notes or internal communication)


[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](./index.html)
