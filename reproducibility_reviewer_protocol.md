---
layout: default
title: "Reviewer Protocol"
---

[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](./index.html)

# PRWP Reproducibility Protocol

This protocol outlines the step-by-step process for verifying the reproducibility of research packages submitted to the World Bank’s PRWP verification team. It ensures that research findings can be independently replicated using the provided code, data, and instructions. The protocol covers the entire workflow—from receiving submissions, verifying completeness and data access, running the package in a clean environment, tracking changes with version control, and checking consistency with the original manuscript, to publishing the final reproducibility package. 

## 1. Receive submission

- Submissions come in through MS Form.
- **Power Automate** sends an automatic reply to the authors, indicating feedback will be provided within two days.
- **Project coordinator**:
  - Log new submissions in the GitHub project.
  - Open an issue with the format **ID: TYPE_ISO_YEAR_NUMBER** (e.g., RR_NGA_2024_213).
  - Types options are the following. 
    - **PP**: published paper.
    - **RR**: Policy Research Working Paper.
    - **FR**: Flagships and reports (this category includes databases so far).
  - Assign the reviewer, download the files, and store them in the designated folder (onedrive named after ID)

## 2.a Verify completeness

- Reviewer verifies the package includes all components as per the checklist [here](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/reproducibility_package_checklist.md): 
  - [ ] Code files going from original data to the results in the paper (and ideally nothing else).
  - [ ] The data files required for analysis.
  - [ ] The raw outputs.
  - [ ] A README file that explains how to run the package and explains data sources and any access restrictions. It's also okay if data details are provided in a separate data availability statement.
  - [ ] A link to the manuscript (if already published) or the manuscript itself.
  - [ ] Make note of any missing components (even if they do not affect the running of the package).
  - [ ] If the package has no README and no information on the data, it gets returned to the author. If there is no main script, but the README is clear, we can work with that, but ideally, it would contain a main script.

## 2.b Verify data access

- [ ] Verify the status of the data: is it public, is it private, is it public but can't be reshared?
  - If the data cannot be directly included in the package (private, confidential, or public but not allowed to be republished), verify that the data is accessible by following instructions in the README or data availability statement.
- [ ] Verify that the instructions for data access are sufficiently clear.
- [ ] Verify that any datasets published directly to the repository do not contain any identifying information.

- [ ] Mer / Luise will start the metadata, to verify that we have everything we need for the publication of the package, mostly in terms of clarity in the data sources.

## 3. Start Clean Environment

- [ ] Start with clean environments to avoid dependency conflicts. Follow these instructions:
  - **Stata:** [Link to instructions](https://worldbank.github.io/wb-reproducible-research-repository/resources/environment-instructions/stata.html)
  - **R:** [Link to instructions](https://worldbank.github.io/wb-reproducible-research-repository/resources/environment-instructions/R.html)
  - **Python:** [Link to instructions](https://worldbank.github.io/wb-reproducible-research-repository/resources/environment-instructions/python.html)
    
## 4. Version control with Git

- [ ] To see the differences between the author's package and our packages across multiple runs, it is useful to create a Git repository.
- [ ] Open GitHub Desktop and create a new repository in the location of the package.
- [ ] Add the `.gitignore` file to avoid tracking all the files. You can use [this template](https://github.com/worldbank/DIME-LaTeX-Templates/blob/master/.gitignore), but you might need to adapt it.
- [ ] Commit the initial package sent by the authors.
- [ ] Important: We only use GitHub Desktop for this process; we won't publish this EVER on GitHub.com.

This will help you see if the outputs are changing after you run the code.

## 5. Run the package

- [ ] Before starting the run of the package delete the author's outputs and the intermediate data. To make sure the code goes from raw data to analysis results, and all outputs are created by the code. Sometimes there are xlsx files the authors used to create figures, make sure this is explained in the README, in which case you wouldn't delete this file.  
- [ ] Check if it runs from start to finish by only changing the top-level directory.
- [ ] Document any lines that needed modifications to run the package.
- [ ] Troubleshoot if the package does not run, often due to missing dependencies.
- [ ] Commit to the Git repo as `first-run`

**Document these critical aspects as you prepare and run the package:**

#### 1. Dependencies
- [ ] **List all Dependencies**: Record all libraries, packages, and other dependencies necessary for the package. This will be saved in the ado folder (Stata), requirements.txt (Python) or renv.lock (R).

#### 2. Changes Made
- [ ] **Detail all Changes Made**: Note any changes made to get the package to run properly, including installation of packages, path modifications, or minor code adjustments. These changes should be documented on the GitHub issue.

#### 3. System Information
- [ ] **Record System Information**: Detail the system specifics where the package is run, including Operating System, Processor, Memory Available, and Software Version (including edition for Stata).

#### 4. Time Spent
- [ ] **Record Time Spent**: Document the time spent, noted in a comment on the GitHub issue, tagging Luise or Mer.


## 6. Confirm initial run

- [ ] If the package runs successfully from start to finish:
  - [ ] Note the run time.
  - [ ] Contact Mer/Luise with your findings.
  - [ ] Mer/Luise will send confirmation to the authors with an estimated date for the return of the report.
  - [ ] Request any missing information for the package or publication from Mer/Luise.

## 7. Verify stability

- [ ] Run the package multiple times based on runtime to ensure stability:
  - Packages with a runtime under a day: run twice.
  - Packages with a runtime over a day: run once.
- [ ] Use Git locally to track and ensure output stability across runs. 
- [ ] Confirm that outputs are consistent across runs:
  - [ ] If discrepancies occur between runs, document them and update the Git repo. If the reproducibility package is in Stata, run `reprun` on it to detect where they start appearing. Mer/Luise may return the package to the authors for corrections, detailing the issues found.

## 8. Verify consistency with the manuscript

- [ ] For papers with more than 10 exhibits in the appendix, randomly select 10 exhibits for review using [this randomization code](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/select_appendix_exhibits.do).
- [ ] Compare the raw outputs generated when running the package to the exhibits in the paper:
  - **Tables**: Check for consistent observation numbers, identical coefficients and standard errors, and matching signs and significance indicators.
  - **Graphs**: Ensure axes, legends, and visual values are consistent.
- [ ] Identify exhibits not requiring reproduction, like timeline figures, and note any tables or analytical outputs not produced by the code provided.
- [ ] Document any discrepancies at the table level and note them in the report (next step). If the authors included their code outputs in the reproducibility package, compare your code outputs with theirs.

## 9. Draft Reproducibility Report

- [ ] Reviewers are tasked with producing a first draft of the reproducibility report using an Overleaf template [here](https://www.overleaf.com/2996348989fbgvwfqrxgtj#6ccc49).
  - [ ] **Successful Reproduction**:
    - Compile any code suggestions separately; these will be communicated to the authors via email by Mer and Luise.
    - In the "Main Findings" section of the report, do not include procedural steps already incorporated into the final package. For example, omit details like the execution of `set varabbrev on` or the installation of libraries that are already included in the provided code.
  - [ ] **Unsuccessful Reproduction**:
    - Include code suggestions directly in the report, detailing the normal steps followed during the package run.
- [ ] If you ran the code include the computer specifications at the end of the report, if someone else did this step, then include that person's computer specifications.
- [ ] Once the draft is complete, send it to Mer and Luise for review.
- [ ] Document the time spent drafting the report in the GitHub issue for the package.

## 10. Prepare Metadata and Publication

- [ ] The reviewer should ensure that all relevant information collected during the verification process is included in the verification report and subsequently integrated into the metadata.
- [ ] Zip the entire reproducibility package folder, preparing it for final archiving and sharing.
- [ ] Determine the public accessibility of the data:
  - [ ] If all data can be shared publicly, include the data files in the zip package.
  - [ ] If there are restrictions on data sharing, clearly describe these restrictions according to the protocols listed [here](https://worldbankgroup.sharepoint.com/sites/WBPRWP/SitePages/PublishingPages/Reproducibility-1688128680253.aspx#1.-reproducibility-package-submission).
  - [ ] If the data source specifies it, include a link to the data license description in the field License URL.
- [ ] Ensure the readme file is in PDF format; if it is not, convert it to PDF and include only this version in the package.
- [ ] Check if the package includes a license:
  - [ ] If not present, add a Modified BSD3 license, available [here](https://opensource.org/license/bsd-3-clause/).
  - [ ] Start the license with: "Copyright (year), Author1, Author2, Author3, ..." followed by the complete license text.

For full instructions on preparing metadata and the publication process, refer to the document [here](./Metadata_Instruction/markdown_schema_v7.pdf).

## 11. Publish package to reproducibility.worldbank.org

- [ ] Draft the catalog entry on QA and have it reviewed by Maria.
- [ ] If approved, send it to Matthew.
- [ ] After Matthew's approval, publish the package to production and request a DOI from Thijs.
- [ ] Update the GitHub repo status and note any pending issues.

## 12. Send reproducibility report and package in RRR

- [ ] Mer/Luise send the finalized report and package back to the author, including any pending issues.
- [ ] Clarify with authors about implementing optional suggestions before publication. If changes are to be made, a revised report must be prepared after resubmission.

## 13. Update the status of the review and add additional information in the GH dashboard

- [ ] After a package is published and sent to the authors, update its status to `Published with missings` or `Done`
    - `Published with missings`: in case it's still pending to update the thumbnail and include the paper DOI and URL. This will be applicable for most cases. If the thumbnail is pending to be updated, add the label `Pending in RRR: thumbnail`. If the data is pending publication, add the label `Pending in RRR: data`.
    - `Done`: in case the package is finalized and there is no missing information in the entry.
- [ ] Add the total time spent on the review. This should include everyone's time, including the coordinators, interns, and all team members.
- [ ] If missing, add the total number of submissions the review took.
- [ ] Add any other missing information such as the run and reproducibility status and any any labels.

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