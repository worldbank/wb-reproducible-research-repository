---
layout: default
title: "Checklist"
---

# Checklist for World Bank Reproducibility Packages

The reproducibility package for World Bank research should include all components in the checklist below.
Authors of Policy Research Working Papers (PRWPs) may request a reproducibility verification at https://prwp.
The authors will provide a link to the complete reproducibility package (OneDrive or GitHub),
information on programming language(s), and approximate run time.
Questions should be directed to reproducibility@worldbank.org.

The reproducibility package will include:
- [ ] A link to the complete reproducibility package on either OneDrive or GitHub. The directory should include all the below components:
- [ ] All data files required for the analysis (for purpose of reproducibility verification only, see here for publication guidelines and embargo options for reproducibility packages).
    - Data should be shared via WB OneDrive with 'DEC Reproducibility Verification - WB Group' when possible.
    - If the data cannot be shared via OneDrive (e.g., large datasets), please email reproducibility@worldbank.org to discuss alternatives.
- [ ] All code files required to go from the original data to the results in the paper.
    - We strongly recommend a main script that runs all code files. The main script should be in the root directory and should set directory path(s) in one location only. If the package does not include a main script, it must have a readme that specifies the order of execution of code files.
    - Code should create all figures and in-text numerical citations not drawn directly from tables.
- [ ] The final manuscript. The manuscript should be included directly if the paper is not yet published. If the paper is already published, please provide the DOI for the paper.
- [ ] A README file that guides future readers through the package and how to proceed with replication. A recommended template  is available [here](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/README_Template.md) 
- [ ] A Data Availability Statement with (this can be part of the README file): 
     -  A link to the dataset(s) (if public) or a description of how/where/when a third party could access the data (if confidential or embargoed). 
     -  It should describe any restrictions to data access, publication or storage/ retention period based on data terms of use.
- [ ] The outputs used for the paper (e.g. tables and figures) in raw form

The reproducibility package should not include:
- Any code or datasets that are not necessary for the set of results included in the paper (or appendices)
- Any extraneous documentation (such as project notes or internal communication)
