---
layout: default
title: "Reviewer Protocol"
---

[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](./index.html)
 
# PRWP Reproducibility Protocol

This protocol outlines the step-by-step process for verifying the reproducibility of research packages submitted to the World Bank’s PRWP verification team. It ensures that research findings can be independently reproduced using the provided code, data, and instructions. The protocol covers the entire workflow—from receiving submissions, verifying completeness including data access and documentation, running the package in a clean environment, tracking changes with version control, and checking consistency with the original manuscript, to publishing the final reproducibility package.

In brief, the process looks like:

![image](https://github.com/user-attachments/assets/3b5270fc-1da0-4f3a-9031-650b8d3f392f)


Find more details below:



## 1. Receive submission

- Submissions come in through the [submission form](https://survey.wb.surveycto.com/collect/prwp_reproducibility?caseid=).
- **Power Automate** sends an automatic reply to the authors, indicating a confirmation will be provided within two days.
- **Project coordinator**:
  - Log new submissions in the GitHub project.
  - Open an issue with the format **ID: TYPE_LOCATION_YEAR_NUMBER** (e.g., RR_NGA_2024_213).
  - Types options are the following.
    - **PP**: published paper.
    - **RR**: Policy Research Working Paper.
    - **FR**: Flagships and reports (this category includes databases so far).
  - Assign the reviewer, download the files, and store them in the designated folder (internal SharePoint named after the review ID)
    - If there are multiple submissions, zip each version and place them in a subfolder titled "files submitted" for organized tracking.
- _Special Case_: If an author submits the reproducibility package via email without completing the submission form, please reply with the submission link and request that they complete the form. Be sure to also include the link to our reproducibility resources for their reference.
- **Record Time Spent**: Track and document the total time spent on the review, starting from the initial receipt of the reproducibility package through to its publication.
- **Document Author Communications**: All communications with the authors must be documented in the GitHub issue for the package. Each message should be reviewed and approved by the coordinator before being sent.

## 2.a Verify completeness

- Reviewer verifies the package includes all components as per the checklist [here](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/reproducibility_package_checklist.md):
  - [ ] Code files going from original data to the results in the paper (and ideally nothing else).
  - [ ] The raw data files required for analysis.
  - [ ] The raw outputs.
  - [ ] A README file that explains how to run the package and explains data sources and any access restrictions. It's also okay if data details are provided in a separate data availability statement.
  - [ ] A link to the manuscript (if already published) or the manuscript itself.
  - [ ] Make note of any missing components (even if they do not affect the running of the package).
  - [ ] If the package has no README and no information on the data, it gets returned to the author. If there is no main script, but the README is clear, we can work with that; but ideally, it would contain a main script.

## 2.b Verify data access

- [ ] Verify the status of the data: is it public, is it private, or is it public but can't be redistributed?
  - If the data cannot be directly included in the package (private, confidential, or public but not allowed to be republished), verify that the data is accessible by following instructions in the README or data availability statement.
- [ ] Verify that data provenance information is complete. This should include:
  - Dataset name
  - Date it was accessed. Month, year is enough.
  - If the data is accessible in a website, it should have a data URL where it can be downloaded.
  - If the data is restricted, the data information should include how it was accessed and how other users could access the data.
- [ ] Verify if the README has the Statement about Rights.
- [ ] Initiate the entry in the metadata editor and verify that we have everything we need for the publication of the package, especially in terms of clarity in the data sources.
- [ ] If the package has not enough information on the data, ask the authors for all missing information.

## 2.c Verify Public Data

- [ ] For datasets that are publicly accessible, verify that the publicly available version matches the data provided by the authors.  
  - Use the provided [Dataset Comparison and Reproducibility Verification Tool](https://github.com/worldbank/wb-reproducible-research-repository/tree/main/resources/compare_datasets) to compare the datasets.  
  - Document any differences between the two versions.  
  - If discrepancies are found:
    - Check with the authors to understand the cause.  
    - If the differences are due to **periodic updates**, note this in the verification report.  
    - If the differences are due to **manual changes**, ask the authors to ensure that the correct version is used and included in the package.


## 3. Start a clean programming environment

- [ ] Start with clean environments to avoid dependency conflicts. Follow these instructions:
  - **Stata:** [Link to instructions](https://worldbank.github.io/wb-reproducible-research-repository/resources/environment-instructions/stata.html)
  - **R:** [Link to instructions](https://worldbank.github.io/wb-reproducible-research-repository/resources/environment-instructions/R.html)
  - **Python:** [Link to instructions](https://worldbank.github.io/wb-reproducible-research-repository/resources/environment-instructions/python.html)

## 4. Version control with Git

- To see the differences between the author's package and our packages across multiple runs, create a Git repository.
- [ ] Open GitHub Desktop and create a new repository in the location of the package.
- [ ] Add the `.gitignore` file to avoid tracking all the files. You can use [this template](https://github.com/worldbank/DIME-LaTeX-Templates/blob/master/.gitignore), but you might need to adapt it.
- [ ] Commit the initial package sent by the authors.
- [ ] Important: We only a local repository for this process, we won't publish this **ever** on GitHub.com.

This will help you see if the outputs are changing after you run the code.

## 5. Run the package

- [ ] Before starting the run of the package, delete the author's outputs and the intermediate data. This makes sure the code goes from raw data to analysis results, and all outputs are created by the code. If there are files the authors used to create figures (for example: Excel files where code results are manually transformed into figures), make sure this is explained in the README, in which case you wouldn't delete this file.  
- [ ] Check if it runs from start to finish by only changing the top-level directory.
- [ ] Document any lines that needed modifications to run the package.
- [ ] Troubleshoot if the package does not run. Keep in mind this is often due to missing dependencies.
- [ ] Commit to the Git repo as `first-run`

**Document these critical aspects as you prepare and run the package:**

#### 1. Dependencies
- [ ] **List all Dependencies**: Record all libraries, packages, and other dependencies necessary for the package. This will be saved in the ado folder (Stata), `environment.yml` (Python) or `renv.lock` (R).

#### 2. Changes Made
- [ ] **Detail all Changes Made**: Note any changes made to get the package to run properly, including installation of packages, path modifications, or minor code adjustments. These changes should be documented on the GitHub issue.

#### 3. System Information
- [ ] **Record System Information**: Detail the system specifics where the package is run, including Operating System, Processor, Memory Available, and Software Version (including edition for Stata).



## 6. Confirm initial run

- [ ] If the package runs successfully from start to finish:
  - [ ] Note the run time.
- [ ] **Verify Stability**:
    - [ ] Run the package one more time based to ensure stability. If the package takes more than 3 days to run, though, feel free to omit this step.
    - [ ] Use Git locally to track and ensure output stability across runs.
    - [ ] Confirm that outputs are consistent across runs:
    - [ ] If discrepancies occur between runs, document them and update the Git repo. If the reproducibility package is in Stata, run `reprun` on it to detect where they start appearing. If it's in R or Python, or if `reprun` didn't work, discuss with the coordinator or the rest of the team to try to find where the issue is. Return the package to the authors for corrections, detailing the issues found. 
- [ ] Send the confirmation to the authors with an estimated date for the return of the report (2 weeks).
- [ ] Notify the authors of any missing information for the publication.



## 7. Verify consistency with the manuscript

- [ ] For papers with more than 10 exhibits in the appendix, randomly select 10 exhibits for review using [this randomization code](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/select_appendix_exhibits.do).
- [ ] Compare the raw outputs generated when running the package to the exhibits in the paper:
  - **Tables**: Check for consistent observation numbers, identical coefficients and standard errors, and matching signs and significance indicators.
  - **Graphs**: Ensure axes, legends, and visual values are consistent.
- [ ] Identify exhibits not requiring reproduction, like timeline figures, and note any tables or analytical outputs not produced by the code provided.
- [ ] Document any discrepancies at the table level and note them in the report (next step). If the authors included their code outputs in the reproducibility package, compare your code outputs with theirs.

## 8. Draft Reproducibility Report

- [ ] Use the Overleaf template [here](https://www.overleaf.com/2996348989fbgvwfqrxgtj#6ccc49) or the template generator (internal only) [here](https://github.com/dime-worldbank/prwp-reproducibility-int/tree/main/verification_report_template/template_generator) to produce a first draft of the reproducibility report.
  - [ ] **Successful Reproduction**:
    - List any code suggestions separately and communicate then to the authors via email when sending the results.
    - In the "Main Findings" section of the report, do not include procedural steps already incorporated into the final package. For example, omit details like the execution of `set varabbrev on` or the installation of libraries that are already included in the provided code. Only include what external users will need to modify to run the code on their computers.
  - [ ] **Unsuccessful Reproduction**:
    - In the "List of exhibits" section of the report include a screenshot of your code results and the paper exhibit. Highlight all the differences so they're noticeable by the authors. For each exhibit, mention any pattern in the discrepancies you might have noticed.
    - Send the report by email. In your email, include a summary of the exhibits that didn't reproduce and actionable information with your suggestions on how to address the reproducibilty issue. Discuss this with the coordinator or rest of the team if needed.
- [ ] If you ran the code, include the computer specifications at the end of the report. If someone else did this step, then include that person's computer specifications.
- [ ] Once the draft is complete, send the report to the coordinator for review. When the coordinator approves it, send it to the authors.

## 9. Prepare Metadata and Publication

- [ ] The reviewer should ensure that all relevant information collected during the verification process is included in the verification report and subsequently integrated into the metadata.
- [ ] Zip the entire reproducibility package folder, preparing it for final archiving and sharing.
      - Zip the results folder and upload it the the respective sharepoint folder.
      - Zip the reproducibility package folder, and upload it the respective sharepoint folder.
- [ ] Determine the public accessibility of the data:
  - [ ] If all data can be shared publicly, include the data files in the zip package.
  - [ ] If the data source specifies it, include a link to the data license description in the field License URL.
- [ ] Ensure the readme file is in PDF format; if it is not, convert it to PDF and include only this version in the package. Name it: `README.pdf`.
- [ ] Check if the package includes a license:
  - [ ] If not present, add a Modified BSD3 license, available [here](https://opensource.org/license/bsd-3-clause/).
  - [ ] Start the license with: "Copyright (year), Author1, Author2, Author3, ..." followed by the complete license text.

For full instructions on preparing metadata and the publication process, refer to the document [here](https://github.com/dime-worldbank/prwp-reproducibility-int/blob/main/Metadata_Instruction/markdown_schema_v7.pdf) (internal link).

## 10. Publish package to reproducibility.worldbank.org

- [ ] Draft the catalog entry on QA and have it reviewed by the reproducibility initiative TTL.
- [ ] Once approved, publish the entry to PROD.

## 11. Send reproducibility report and package in RRR

- [ ] Send the finalized report with the link to the published package to the authors, including any pending issues.

## 12. Update the status of the review and add additional information in the GH dashboard

- [ ] After a package is published and sent to the authors, update its status to `Published with missings` or `Done`
    - `Published with missings`: in case it's still pending to update the thumbnail and include the paper DOI, URL, and PRWP number. This will be applicable for most cases. If the thumbnail is pending to be updated, add the label `Pending in RRR: thumbnail`. If the data is pending publication, add the label `Pending in RRR: data`.
    - `Done`: in case the package is finalized and there is no missing information in the entry.
- [ ] Add the total time spent on the review. This should include everyone's time, including the coordinators, interns, and all team members.
- [ ] If missing, add the total number of submissions the review took.
- [ ] Fill any missing information on the dashboard.





# Special cases

## New versions of a published entry

New versions are updates of the code or data that follow a modification of a manuscript exhibit or a new exhibit that was not included in the original reproducibility package.
A new version should be included as a new entry in RRR.
Updates only to the documentation or metadata are not considered new versions and they can be updated in the same entry.
Cases that do not fall in these examples should be discussed in the weekly team meeting.

Follow these steps to update a new version of a reproducibility package:

- [ ] Create a new entry for the latest version using the same ID + `v2` (or `v3` or `v4` if it's the third or fourth version). You can download the metadata JSON of the original entry and upload it so you don't have to fill in all the fields from scratch.
- [ ] In the new entry, make sure to update any relevant fields, especially the field `version` in Metadata Information.
- [ ] Once it's approved by the coordinators or TTL, publish the new version to prod.
- [ ] Notify Thijs that there is a new version of an existing package so he can create the new DOI of the new version.
- [ ] Add these changes to the original version:
    - Take note of the old version's DOI and save it.
    - Add: `[OLD VERSION]` to the entry title. It should look like this: `[OLD VERSION] Reproducibility package for Effects of a community-driven water, sanitation, and hygiene intervention on diarrhea, child growth, and local institutions: a cluster-randomized controlled trial in rural Democratic Republic of Congo`.
    - Add: `[PLEASE NOTE THAT THIS REPRODUCIBILITY PACKAGE WAS UPDATED TO A NEW VERSION. THE UPDATED VERSION IS AVAILABLE IN THIS LINK: https://reproducibility.worldbank.org/index.php/catalog/XXXXXXXXXXXXX]` as a prefix to the abstract.
    - Publish these two changes to prod.
    - Remember that updates to prod delete the DOI. From the admin prod portal, manually add the DOI you previously saved.
- You can see an example of an updated entry [here](https://reproducibility.worldbank.org/index.php/catalog/222)

[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](./index.html)
