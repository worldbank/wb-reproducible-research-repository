# Reproducibility package checklist (World Bank / DIME Analytics)

The audit in Phase 1 checks the project against every item below. For each, record present, partial, or missing, with the filename or line as evidence. Source: World Bank reproducible research repository (worldbank/wb-reproducible-research-repository), reproducibility_package_checklist.md. Questions go to reproducibility@worldbank.org.

## Required components

### 1. Data
- All data files required for verification are included.
- The package starts from documented data. For traceability it should start from original (unprocessed) data.
- If an input dataset has restricted access, it is not in the original submission; it can be shared after an NDA, or under the virtual verification protocol where data is never shared directly.
- If raw input is very large, the package may start from a "usable data" intermediate that is fully documented and citable, provided the README gives (i) provenance and access instructions for the raw sources, and (ii) scripts or written protocols that reproduce the usable dataset when access is granted.

### 2. Code
- All code files needed to go from the original data to the results in the paper.
- A main (master) script that runs all code after the reviewer changes only the top level directory. Templates: assets/main.do (Stata), assets/main.R (R).
- If there is no main script, the README states the order of execution of code files.
- Code creates all exhibits and all in text numbers not drawn directly from tables.
- Excel only packages follow the separate Excel guidelines.
- If source cannot be shared immediately, the package may instead give build instructions and compiler versions, a container image, or deterministic binaries plus environment details, and state source escrow terms (for example released at acceptance or after embargo).

### 3. README
- Guides a future reader through the package and how to replicate. A generator and a template (assets/README_template.md) are available.
- Software and version used.
- The exact line(s) in the main script to change to run on a different machine.
- Mapping of every output to the script that generates it.
- Any specific guidance for the reviewer.

### 4. Data availability statement (may be part of the README)
- Summary classification: all data publicly available, some data restricted, or no data publicly available.
- For each dataset: filename, source, URL, access year. A public link, or step by step access instructions if restricted or embargoed.
- Description of any restrictions on access, publication, or retention from the data terms of use.
- Rights statement confirming the authors had legitimate access to all data used.

### 5. Outputs used in the paper
- Tables and figures in raw form.
- For very large datasets or simulations (compute time over 5 days), the Artifact Pathway allows pre computed outputs plus code and SHA256 checksums for integrity checks.

### 6. Manuscript
- The final version that will be published, used to review exhibits one by one.
- It must reflect the final version of the code. About 35% of reproducibility failures come from version control mismatches between manuscript and code.

## Must not be included
- Code or datasets not needed for the results in the paper or appendices.
- Extraneous documentation: project notes, internal communication.

## Recommended folder structure
```
Data
  ├── Raw
  └── Cleaned
Code
  ├── main            (master script: sets paths, installs packages, runs the rest in order)
  ├── 01_cleaning
  └── 02_analysis
Outputs
  ├── Main
  │   ├── Tables
  │   └── Figures
  └── Annex
      ├── Tables
      └── Figures
```
Use the project's existing conventions where they already satisfy the standard. Do not force a rename the standard does not require.
