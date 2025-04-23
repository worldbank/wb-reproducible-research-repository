---
layout: default
title: "Guide For Flagships"
---

[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](../index.html)

# 🧭 Building a Reproducibility Package (Flagship Edition)

**World Bank Reproducible Research Initiative**  🔗 [reproducibility.worldbank.org](https://reproducibility.worldbank.org)

---

## 📦 What Is a Reproducibility Package?

A reproducibility package includes everything needed to replicate the findings in a paper:

| Includes | Details |
|----------|---------|
| 📑 **Documentation** | README, Data Availability Statement (DAS), figure/table mapping |
| 📂 **Code** | All needed scripts to clean data and generate final outputs |
| 📊 **Data** | Raw data and/or detailed access instructions to obtain it |

> 💻 **Standard: Computational Reproducibility**  
> A third party can reproduce the **exact findings** in the paper using the data, code, and documentation provided by the author.

✅ Verified packages are published in the [Reproducible Research Repository](https://reproducibility.worldbank.org). (RRR)

---

## 🔁 Reproducibility Workflow

| Step               | What Happens                                                                                           |
|--------------------|--------------------------------------------------------------------------------------------------------|
| **Submission**   | Authors prepare the reproducibility package and [submit it for verification](https://survey.wb.surveycto.com/collect/prwp_reproducibility). |
| **Verification** | The reproducibility team tests whether the results can be fully reproduced using the submitted code and data. A detailed verification report is issued. |
| **Publication**  | If reproducible, the package is published on the [Reproducible Research Repository (RRR)](https://reproducibility.worldbank.org) with a DOI, metadata, and verification seal. |


---

## 📦 Components of a Good Reproducibility Package — *With Flagships in Mind*

📌 **Flagship projects typically involve multiple datasets, chapters, and contributors**, which makes reproducibility more complex. Below are the key components of a strong package, along with specific tips for flagships to ensure clarity and coordination.

| Component             | Description & Flagship-Specific Tips                                                                 |
|----------------------|-------------------------------------------------------------------------------------------------------|
| **README File**       | 📌 **Essential for flagships**: Provides a clear overview of the analysis and full guidance for replicators.<br> - Include step-by-step instructions on how to run the code or replicate the findings. <br>- Include a **list of exhibits**: indicate which are produced by the package and which come from external sources (with citations).<br>- Data Availability Statement: define **all datasets used**: include source (with URL), version, and access date (more on next point).<br><br>🔗 **Use our templates**: [Markdown](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/README_Template.md) · [Word](https://github.com/worldbank/wb-reproducible-research-repository/raw/refs/heads/main/resources/README_Template.docx) |
| **Data Availability Statement (DAS)** | 📌 **Flagships often use a mix of public, restricted, and internal datasets**, so this is a key component. The DAS must:<br><br>- List **every dataset** used in the analysis, regardless of size or access level.<br>- Specify **access conditions** for each (e.g., public with URL, WB staff only with explanation of how data was obtained, etc.)<br><br>🔗 [Example DAS for Flagship](https://reproducibility.worldbank.org/index.php/catalog/250/download/731) |
| **Code Files**        | - 📁 Modular scripts organized by task (e.g., `cleaning.R`, `analysis.do`) and managed via one main script (`main.R` or `main.do`).<br>- List all external dependencies (e.g., R packages, ado files, Python libraries).<br>- 📌 For flagships: organize code **by chapter or module**, and ensure the full team agrees on versioning and folder structure. |
| **Data**              | - Keep **raw** and **processed** data separate.<br>- Document all data transformations **in code**. If manual edits were made, explain them in the README.<br>- Clean the package before submission: remove unused files.<br>📌 For flagships: ensure **consistent data versions** across chapters and authors. Store original data in permanent, team-accessible locations. |
| **Final Outputs**     | - Include **all raw outputs** used in the report (e.g., CSVs, graphs, LaTeX tables).<br>- 📌 If final outputs were sent to the design team, **document which ones**.<br>- A final verification run should confirm that report exhibits match raw outputs. |


---

## 🚧 Common Pitfalls & How to Avoid Them

| 🚫 Problem | ✅ Solution |
|-----------|-------------|
| Version control. Code results ≠ Report exhibits | Run full code right before submission and make sure outputs match your manuscript. Archive final outputs. |
| Manual Excel edits not documented | Document all manual steps (e.g., which Excel tab → which figure). Automate when possible. |
| Starts from intermediate data | Archive raw data + document **entire** cleaning pipeline. |
| Instability. Results vary across runs | Control random seeds. Test stability. Contact reproducibility team for help. |

---

## 🚀 Start Early: Timeline & Submission Steps

| 📅 Phase               | Action Items                                                                      |
|------------------------|---------------------------------------------------------------------------------------|
| **Kickoff**            | - Assign a reproducibility lead per chapter or module<br>- Define folder and file structure for the whole team<br>- Align on data sources and archive raw versions from day 1 |
| **During project**     | - Update README and DAS progressively<br>- Automate figures/tables as much as possible<br>- Keep scripts modular and coordinated across chapters |
| **Before submission**  | - Run the entire pipeline using your `main` script<br>- Clean the repository: only include necessary data, code, and outputs<br>- Ensure exhibits match the report exactly <br>- Review our [checklist](https://worldbank.github.io/wb-reproducible-research-repository/reproducibility_package_checklist.html) to make sure everything is ready |
| **To submit**          | Fill out the [Reproducibility Verification Request Form](https://survey.wb.surveycto.com/collect/prwp_reproducibility) and share your package |

💡 Start documenting from day 1—it will save time and confusion at submission.

---

📨 **Questions or support?**  
📧 reproducibility@worldbank.org  
🔗 [Reproducible Research Resources](https://worldbank.github.io/wb-reproducible-research-repository/resources.html)

[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](../index.html)

