# Reproducibility Report Template - Instructions

This document provides guidance on how to complete the reproducibility report template (`main.tex`) for World Bank reproducibility reviews. Download the zipped folder (reproducibility_report_template.zip) and edit it in a LaTeX editor, or upload the folder to Overleaf.

## Overview

The template consists of three main sections:

1. **Main Findings** - Summary of reproducibility verification
2. **List of Exhibits** - Detailed status of each figure/table
3. **Reproduction Environment** - Technical specifications

## Getting Started

1. Open `main.tex` in a LaTeX editor
2. Update the header information (lines 103-105):
   - Replace "An incredibly cool title" with the paper title
   - Replace "RR_WLD_2026_500" with the actual Package ID
   - Add your name
   - The date will auto-generate

## Section 1: Main Findings

### Items to Complete

#### 1.1 Reproducibility Status (choose one)
Select the appropriate statement (lines 132-135):

- **Red**: If exhibits failed to reproduce - specify how many.
- **Green (main only)**: If only main paper exhibits were verified and reproduced.
- **Green (main + appendix)**: If main paper and randomly selected 10 empirical appendix exhibits reproduced.

#### 1.2 Code Execution Instructions
Fill in line 137-140 with specific instructions. Use software-specific templates:

**For Stata:**
```latex
\item Updating the working directory in line X of the do-file "XXX.do", and running it.
```

**For R:**
```latex
\item Opening the R project "XXX.Rproj"
\item Restoring the environment by running renv::restore() and following the prompts.
\item Opening the XXX.R and running the code.
```

**For Python:**
```latex
\item Restoring the environment in "XXX"
\item Running the "XXX.py"
```

**For mixed software:** Combine the above as needed.

#### 1.3 Stability & Runtime Information (lines 142-146)
- Specify whether stability checks were done or not
- Specify execution time: "X minutes" or "X hours"
- Update date and source of paper version

#### 1.4 Verification Process and Data Handling (starting at line 149).

Fill in the data types used. Choose from:
- **Open** - Publicly available, included in package
- **Accessible** - Publicly available, not included in package
- **Limited-access** - Requires purchase or human approval or only available to World Bank Staff
- **Restricted** - Available only from authors, Government, etc
- **Forthcoming** - Will be made available in the future (e.g., World Bank Microdata Library)

Example text to customize:
```latex
\item The reproducibility package relies on [NUMBER] types of data: [list types].

\item Open data is included in the public reproducibility package.

\item Reviewers used [forthcoming/accessible/restricted] data provided directly 
by the authors to conduct the reproducibility verification, and this is not included 
in the public reproducibility package. [The data is forthcoming on the World Bank 
Microdata Library.]

\item Reviewers verified that the limited-access data matches what was provided 
by the authors; results of this verification are documented in the file 
\textit{comparison\_report.csv}.

\item \textit{data\_hash\_report.csv} lists the SHA256 hashes of all files in 
the Data folder to support data integrity checks.
```

#### 1.5 Reproducibility Summary (starting at line 165).

Select ONE option for each category:

##### **Data** (choose one):
- All data sources are publicly available and included in the reproducibility package.
- All data sources are publicly available but not all are included in the reproducibility package.
- All data is not yet publicly available but is expected to be made available through the [World Bank Microdata Library] in the future.
- Some data is not yet publicly available but is expected to be made available through the [World Bank Microdata Library] in the future.
- All data is temporarily embargoed by the authors (expected to be made public in the future).
- Some data is temporarily embargoed by the authors (expected to be made public in the future).
- Some data is restricted/limited-access and has not been included in the reproducibility package. For more details, please refer to the README file.
- All data is restricted/limited-access and has not been included in the reproducibility package. For more details, please refer to the README file.

##### **Code** (choose one):
- All code files (from cleaning to analysis) are included in the reproducibility package.
- All code files are included in the reproducibility package but operate from intermediate data, not raw data.
- Some code files are publicly available and included in the reproducibility package.
- All code files are temporarily embargoed by the authors (expected to be made public in this repository in the future).
- Some code files are temporarily embargoed by the authors (expected to be made public in this repository in the future).
- Some code files are restricted (details provided in the README file).
- All code files are restricted (details provided in the README file).
- No code files are used in the reproducibility package.

##### **Outputs** (choose one):
- All outputs are generated by code included in the reproducibility package.
- Some outputs are generated by code that is not included in the reproducibility package.
- Some outputs are not generated by code (created manually in Excel, ArcGIS, etc) but instructions for producing these outputs are included in the README file.

##### **Dependencies Environment** (choose one):
- The reviewers created a new environment using the latest versions of dependencies available at the moment of the review.
- The reviewers created a new environment for dependencies using specific versions defined by the authors in the README file.
- The reviewers reproduced an existing environment for dependencies using dependency files or an environment metadata file provided by the authors.
- The reproducibility package does not use external dependencies.

## Section 2: List of Exhibits

### Color Coding System
Use these LaTeX color codes for exhibit status:

- `\textcolor{OliveGreen}{Reproduced.}` - Perfect reproduction from the code
- `\textcolor{LimeGreen}{Results reproduced, but table or figure includes manual changes from code output}` - Minor manual edits,  like when results are shown in Stata console. 
- `\textcolor{Gray}{Does not apply}` - Not applicable (If figure is a diagram, or cited from another paper)
- `\textcolor{Goldenrod}{All values reproduced}` - Not common category, but used when we verified the values and not the graphs, for instance, when reviewing the underlying data used to produce a map. 
- `\textcolor{BurntOrange}{Could not be verified: EXPLAIN WHY}` - Unable to verify. For instance, if the code did not produce the exhibit. 
- `\textcolor{Red}{Does not reproduce: EXPLAIN WHAT CHANGES}` - Failed to reproduce. Here we also add screenshots or a table of what is different between the paper and the code-produced output. 

### List All Exhibits

1. List every figure and table from the paper
2. Assign status to each
3. For failed reproductions, include side-by-side comparison (see example at lines 203-218)

### Appendix Exhibits

If verifying appendix exhibits through sampling:
1. Specify the seed used for random selection
2. List Stata version used for selection
3. List all randomly selected exhibits
4. Reference the selection code: https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/select_appendix_exhibits.do

## Section 3: Reproduction Environment

Fill in your computer specifications (lines 252-255):
- Operating System
- Processor
- Memory
- Software versions

## Example Completed Entry

```latex
\item \textbf{Verification Process and Data Handling}: 
\begin{itemize}
    \item The reproducibility package relies on 2 types of data: open and forthcoming.
    
    \item Open data is included in the public reproducibility package.
    
    \item Reviewers used forthcoming data provided directly by the authors to conduct 
    the reproducibility verification, and this is not included in the public 
    reproducibility package. The data is forthcoming on the World Bank Microdata Library.
    
    \item \textit{data\_hash\_report.csv} lists the SHA256 hashes of all files in 
    the Data folder to support data integrity checks.
\end{itemize}

\item \textbf{Reproducibility Summary}: 
\begin{itemize}
    \item \textbf{Data}: Some data is not yet publicly available but is expected to 
    be made available through the World Bank Microdata Library in the future.
    \item \textbf{Code}: All code files (from cleaning to analysis) are included in 
    the reproducibility package.
    \item \textbf{Outputs}: All outputs are generated by code included in the 
    reproducibility package.
    \item \textbf{Dependencies environment}: The reviewers created a new environment
   using the latest versions of dependencies available at the moment of the review.
\end{itemize}
```

## Checklist Before Submission

- [ ] Title and package ID updated in header
- [ ] Your name added
- [ ] Reproducibility status selected (red/green)
- [ ] Code execution instructions filled in with specific details
- [ ] Runtime specified
- [ ] Paper version/date documented
- [ ] Verification Process and Data Handling section completed
- [ ] Reproducibility Summary section completed with all 4-5 categories
- [ ] All exhibits listed with status
- [ ] Side-by-side comparisons added for failed reproductions
- [ ] Appendix sampling methodology documented (if applicable)
- [ ] Reproduction environment specifications filled in

## Compiling the Report

After completing the template:
1. Compile with Overleaf or LaTeX (pdfLaTeX recommended)
2. Review the PDF output for formatting
3. Ensure all images display correctly
4. Save final PDF as `reproducibility_report_[PackageID].pdf` (e.g. reproducibility_report_RR_WLD_2026_541)

## Updating the Report
If the exhibits are not reproducible and the authors have shared an updated package, follow these steps:

1. Do not overwrite the existing report in `main.tex`.
2. Copy everything from `main.tex`, create a new file in the same directory, and name it `v2.tex` (update the version number based on the submission round).
3. Update the submission label on line 104 — for example, replace "First Submission" with "Second Submission".
4. Complete the report following the same steps as the initial submission.

## Additional Resources

- Not sure how to categorize an exhibit? See `example.tex` in this directory for sample color coding examples
- For a fully completed report, see reproducibility_report_example_reproduced.pdf and reproducibility_report_example_not_reproduced.pdf in this folder.
- [Appendix exhibit selection tool](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/select_appendix_exhibits.do)
- [World Bank Reproducibility Guidelines](https://worldbank.github.io/wb-reproducible-research-repository/guidance_note_wb.html)

## Questions?

Contact the reproducibility team at reproducibility@worldbank.org
