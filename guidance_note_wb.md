---
layout: default
title: "Guidance to Authors"
---

[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](./index.html)

# Guidance Note for World Bank Staff and Consultants on Reproducible Publications

To enhance the credibility, transparency, and impact of its analytical products, the World Bank’s Development Economics Vice Presidency (DEC) launched the [Reproducible Research Repository](https://reproducibility.worldbank.org/). 
The repository documents the data and code underlying Bank analytics and provides reproducibility packages, complete sets of instructions and materials required to regenerate the results of specific publications.  

By making these packages available, the repository allows users to scrutinize the underlying data and methodological choices, reproduce results, and build on existing research. 
To ensure reliability, all reproducibility packages are verified for completeness and functionality before they are posted.  

Reproducibility verification ensures that a reviewer can regenerate exactly the outputs (statistical tables and data visualizations) presented in a publication by running the reproducibility package provided by the authors. 
In this process, the reviewer checks that the package is:  

- **Complete**: able to generate every output in the manuscript from the original data  
- **Stable**: producing identical results each time it is executed  
- **Consistent**: reproducing tables and figures that match those in the publication  

This is not a review of the accuracy or quality of the code, the data, or the methods applied, or the validity of the research itself.  

Detailed guidelines on the process for submission, verification, and publication of reproducibility packages are included below. World Bank staff and consultants can address any questions to the WB Reproducibility team at [reproducibility@worldbank.org](mailto:reproducibility@worldbank.org). 
Please review our FAQs [here](https://worldbank.github.io/wb-reproducible-research-repository/reproducibility_FAQs.html) as well.  

---


## Reproducibility package submission

To begin, authors must complete the [Reproducibility Verification Request Form](https://survey.wb.surveycto.com/collect/prwp_reproducibility?caseid=) and submit their package through a GitHub repository, a OneDrive folder, another cloud-based sharing service, or, for small datasets, a compressed folder sent directly by email to reproducibility@worldbank.org. 

The package should follow the [Reproducibility Package Checklist](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/reproducibility_package_checklist.md). 
It needs to clearly document the data, code, and steps used to generate the paper’s results. 
A well-structured package typically organizes data, code, and outputs in separate folders, includes a README file, and provides a main script that specifies the order in which the code should be run. 
Supporting resources can be found [here](https://worldbank.github.io/wb-reproducible-research-repository/resources.html).




#### Documenting Data  

A reproducibility package should always begin from documented data sources, often referred to as *source data*. Source data is a citable dataset that is properly documented, either publicly accessible or archived in a World Bank internal catalog, and serves as the starting point for reproducibility.

For each external dataset used, authors are expected to provide a full data citation. This should include a URL for publicly available datasets, or clear instructions on how to compile or request access for datasets that cannot be redistributed, or require purchase or human approval.

Any original data generated for the publication that is owned by the World Bank **must** also be deposited in one of the Bank’s official repositories: 

-	[Microdata Library (MDL)](https://microdatalib.worldbank.org/index.php/data-deposit) for survey data  
- [Development Data Hub (DDH)](https://datacatalog.worldbank.org/int/data/add) for geospatial, administrative, time series, and other types of data  

Access to these submission portals is limited to World Bank staff. 
Depositing original data in the appropriate repository ensures compliance with the [Bank Procedure for Development Dataset Acquisition, Archiving and Dissemination](https://worldbankgroup.sharepoint.com/sites/ppfonline/PPFDocuments/ef8d76aeb7b541509672704768ee0c24.pdf) (link requires WB intranet access).

In the case of confidential and/or restricted-access data, the authors have the following options which may be used as appropriate, these are listed in order of preference:

1. **Non-Disclosure Agreement (NDA)**  
   Reviewers sign an agreement stating that they will access the data only for reproducibility checks and will not re-use it. 
   Where needed, reviewers may request data directly from the provider under agreed terms.  

2. **Virtual Reproducibility Verification**  
   The reviewer observes the author running the package in a clean environment during a virtual meeting. 
   Once confirmed, the author shares the log and output files for detailed comparison with the manuscript. 
   See detailed protocol [here](https://worldbank.github.io/wb-reproducible-research-repository/guidance/virtual_reproducibility_verification_protocol.html).  

3. **Synthetic Data**  
   Authors provide fake but structurally similar data in the public package. 
   The reviewer verifies the package with the actual data through one of the secure methods above.  

#### Exemptions  
Exemptions apply to literature reviews, theoretical papers, and qualitative research. A
ny other exemption must be approved by the author’s manager. 
Managers may also approve temporary embargoes for data collected by World Bank teams, to preserve intellectual property while the team seeks academic publication.  

---


## Reproducibility package verification

When the review team receives a reproducibility package, the verification process takes place in steps documented below. 
If the requirements are not met at any point, the package is returned to the authors along with detailed feedback on the revisions needed.

#### Step 1. Verify Completeness and Data Access  
The reviewer checks that the package includes all required components, following the reproducibility checklist. 
Data provenance must be fully documented. 
For datasets that are publicly accessible but cannot be redistributed in the package, the reviewer confirms that the publicly available version matches the data provided by the authors.  

#### Step 2. Run the Code  
The reviewer attempts to run the package following the instructions provided. 
Ideally, this involves changing only the top-level directory global in the main script and then running the script to reproduce the results. 
This is referred to as a *“one-button run.”*  

#### Step 3. Check Reproducibility of Outputs  
If the code runs from beginning to end, the reviewer evaluates whether the outputs are complete, stable, and consistent with the manuscript. 
Specifically, the reviewer checks:  

- Descriptive statistics, sample sizes, regression point estimates, and standard errors match those reported in the manuscript. Minor differences of less than 0.01 units are documented but are not grounds for rejection.  
- Graphs and visualizations match those in the manuscript, including the data displayed, axis titles and ticks, and legends.  
- Outputs are stable across multiple runs, meaning no changes are observed between runs.  
- The code produces all statistical tables and data visualizations reported in the paper.  
- If the appendix contains more than 10 exhibits, the reviewer will verify a random sample of 10, selected using a [reproducible randomization code](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/select_appendix_exhibits.do).  

#### Step 4. Reporting  
Once verification is successfully completed, the reviewer issues a report describing the scope and outcome of the process. 
Sections of the paper that are theoretical or involve model-based simulations are excluded from verification, and the reproducibility certificate will note any such exclusions.  

For more details, see the complete [Reproducibility Verification Protocol](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/reproducibility_reviewer_protocol.md).  

---


## Reproducibility package publication

Once a reproducibility package is verified, the reviewer prepares it for publication in the Reproducible Research Repository at [reproducibility.worldbank.org](https://reproducibility.worldbank.org).
This includes preparing the metadata and drafting the catalogue entry.

Each published reproducibility package will include:  

- A README file with instructions for running the package and a clear Data Availability Statement (DAS)  
- A zipped folder containing all code files and, where permissible, the data files  
- A license file  
- The reproducibility report with details of the verification  
- A file with the SHA256 hashes of all datasets in the data folder, to enable integrity checks  
- A comparison report documenting any differences between the datasets used by the authors and the datasets currently available (applicable for Limited Access or Accessible data types)  

Every reproducibility package will be assigned a DOI to support discovery, cross-linking, and citation.  

#### Treatment of Data in Published Packages  
Depending on access restrictions, data in the reproducibility package will take one of the following forms:  

1. **Data already published (internally or externally):**  
   The Data Availability Statement (DAS) links to the data with access instructions and version details. 
   If permitted, the data may also be included directly in the package, which is recommended when no DOI or stable link exists. ch is recommended when no DOI or stable link exists.  

2. **Proprietary or confidential data:**  
   The DAS explains how third parties may access the data. 
   Input data will not be included, though derivative datasets may be shared if allowed. 
   Data available to Bank staff should also be deposited in the internal catalogue and linked in the DAS.  

3. **World Bank–owned unpublished data:**  
   These should be added to the Microdata Library (if microdata) or the Development Data Hub (if any other type of data). 
   The DAS will link to the published data. 
   Authors may also request a renewable one-year embargo on data or code publication to allow time for follow-up work with newly collected datasets or developed code.  

4. **Data with limited stand-alone value:**  
   This includes manually constructed or derivative datasets drawn from public sources. 
   If unrestricted, such datasets may be published directly in the package. 
   This also includes dummy datasets, which can substitute for restricted data to allow users to verify that the code runs correctly.  


The reproducibility package will be cross-linked with the PRWP in Documents & Reports. 
The publication cover page will display the Reproducible Research Seal, indicating that a verified package is available, along with its permanent URL.


[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](./index.html)


