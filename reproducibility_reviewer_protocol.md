
# PRWP Reproducibility Protocol

## 1. Receive submission

- Submissions come in through MS Form.
- Power Automate sends a reply to the authors that we will get back with initial comments within a day.
- [ ] Project coordinator: log new submissions in the GitHub project, open the issue, and assign them to the reviewer, download the files, and place them in our folder.

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

- [ ] Project coordinator will start the metadata, to verify that we have everything we need for the publication of the package, mostly in terms of clarity in the data sources.

## 3. Start Clean Environment

- [ ] To ensure we don't introduce any errors from personal environments/dependencies, we want to start from clean environments. Follow these instructions to start in a clean environment:
  - Stata: [Link to instructions for starting Stata in a clean environment](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/environment-instructions/stata.md)
  - R: [Link to instructions for starting R in a clean environment](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/environment-instructions/R.md)
  - Python: [Link to instructions for starting Python in a clean environment](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/environment-instructions/python.md)
    
## 4. Version control with Git

- [ ] To see the differences between the author's package and our packages across multiple runs, it is useful to create a Git repository.
- [ ] Open GitHub Desktop and create a new repository in the location of the package.
- [ ] Add the `.gitignore` file to avoid tracking all the files. You can use [this template](https://github.com/worldbank/DIME-LaTeX-Templates/blob/master/.gitignore), but you might need to adapt it.
- [ ] Commit the initial package sent by the authors.
- [ ] Important: We only use GitHub Desktop for this process; we won't publish this EVER on GitHub.com.

This will help you see if the outputs are changing after you run the code.

## 5. Run the package

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
- [ ] **Record Time Spent**: Document the time spent at each stage, noted in a comment on the GitHub issue, tagging Project coordinator.


## 6. Confirm initial run

- [ ] If the package runs successfully from start to finish:
  - [ ] Note the run time.
  - [ ] Contact Project coordinator with your findings.
  - [ ] Project coordinator will send confirmation to the authors with an estimated date for the return of the report.
  - [ ] Request any missing information for the package or publication from Project coordinator.

## 7. Verify stability

- [ ] Run the package a second time to ensure stability:
  - Packages with a runtime under a day: run twice.
  - Packages with a runtime over a day: run once.
- [ ] Commit the results of your second run as `second-run`
- [ ] Use GitHub Desktop locally to track and ensure output stability across runs. You can use the slider for graphs, and the changes window for .txt, .csv. 
- [ ] Confirm that outputs are consistent across runs:
  - [ ] If discrepancies occur between runs, document them and update the Git repo. If the reproducibility package is in Stata, run `reprun` on it to detect where they start appearing. Project coordinator may return the package to the authors for corrections, detailing the issues found.

## 8. Verify consistency with the manuscript
- [ ] If the paper includes an appendix section with more than 10 exhibits, use the randomization code to select 10 exhibits for review.
- [ ] Compare the raw outputs generated when running the package to the exhibits in the paper:
  - **Tables**: Check for consistent observation numbers, identical coefficients and standard errors, and matching signs and significance indicators.
  - **Graphs**: Ensure axes, legends, and visual values are consistent.
- [ ] Identify exhibits not requiring reproduction, like timeline figures, and note any tables or analytical outputs not produced by the code provided.
- [ ] Document any discrepancies at the table level and note them in the report (next step). If the authors included their code outputs in the reproducibility package, compare your code outputs with theirs.

## 9. Draft Reproducibility Report

- [ ] Reviewers are tasked with producing a first draft of the reproducibility report using an Overleaf template.
  - [ ] **Successful Reproduction**:
    - Compile any code suggestions separately; these will be communicated to the authors via email by Project coordinator.
    - In the "Main Findings" section of the report, do not include procedural steps already incorporated into the final package. For example, omit details like the execution of `set varabbrev on` or the installation of libraries that are already included in the provided code.
  - [ ] **Unsuccessful Reproduction**:
    - Include code suggestions directly in the report, detailing the normal steps followed during the package run.
- [ ] If you ran the code include the computer specifications at the end of the report, if someone else did this step, then include that person's computer specifications.
- [ ] Once the draft is complete, send it to Project coordinator for review.
- [ ] Document the time spent drafting the report in the GitHub issue for the package.

## 10. Prepare Metadata and Publication

- [ ] The reviewer should ensure that all relevant information collected during the verification process is included in the verification report and subsequently integrated into the metadata.
- [ ] Zip the entire reproducibility package folder, preparing it for final archiving and sharing.
- [ ] Determine the public accessibility of the data:
  - [ ] If all data can be shared publicly, include the data files in the zip package.
  - [ ] If there are restrictions on data sharing, clearly describe these restrictions according to the protocols listed [here](https://worldbankgroup.sharepoint.com/sites/WBPRWP/SitePages/PublishingPages/Reproducibility-1688128680253.aspx#1.-reproducibility-package-submission) (**internal view only**).
- [ ] Ensure the readme file is in PDF format; if it is not, convert it to PDF and include only this version in the package.
- [ ] Check if the package includes a license:
  - [ ] If not present, add a Modified BSD3 license, available [here](https://opensource.org/license/bsd-3-clause/).
  - [ ] Start the license with: "Copyright (year), Author1, Author2, Author3, ..." followed by the complete license text.

## 11. Publish package to reproducibility.worldbank.org

- [ ] Draft the catalog entry on QA and have it reviewed by Team Leader.
- [ ] If approved, send it to Microdata Library Program Manager.
- [ ] After Microdata Library Program Manager's approval, publish the package to production and request a DOI.
- [ ] Update the GitHub repo status and note any pending issues.

## 12. Send reproducibility report and package in RRR

- [ ] Project coordinator sends the finalized report and package back to the author, including any pending issues.
- [ ] Clarify with authors about implementing optional suggestions before publication. If changes are to be made, a revised report must be prepared after resubmission.
