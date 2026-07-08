---
layout: default
title: "Resources"
---

[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](./index.html)

# Resources for Reproducibility

This section provides useful templates, main files, and environment setup instructions to help you build reproducibility packages efficiently.

## README Templates

- [README Generator](https://dime-worldbank.github.io/wb-reproducible-research-repository-automation/)  
  *Use this tool to create your own README.* The app includes all the essential components of a high-quality README and will generate a Word document based on your responses.
  
- [README Template (Markdown)](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/README_Template.md)  
  *Use this as a guide if you're working on a reproducibility package to include all required elements.*

- [README Template (Word)](./resources/README_Template.docx)  
  *Same content as the Markdown template but in Word format.*

---

## Main Files for Reproducibility

These are templates for main scripts to allow **one-click reproducibility** in both **R** and **Stata**. Use them to automate your replication process:

- **R Main File:** [main.R](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/main.R)  
- **Stata Main File:** [main.do](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/main.do)

---

## AI Skill for Reproducibility Packages

The **WB Reproducibility Package skill** lets an AI coding agent (Claude Code, GitHub Copilot, or Claude.ai) help you prepare a package that meets the World Bank reproducibility standard — before submitting for verification. It audits your project against the [official checklist](./reproducibility_package_checklist.html) and the most common failure flags, proposes a build plan for your approval, drafts the README and main script, and verifies that every exhibit regenerates from a clean run.

- **Get the skill:** [ai-skills/reproducibility-skill](https://github.com/worldbank/wb-reproducible-research-repository/tree/main/ai-skills/reproducibility-skill)  
  *Installation and usage instructions are in the folder's README. A ready-to-upload `.zip` for Claude.ai is attached to the [latest release](https://github.com/worldbank/wb-reproducible-research-repository/releases/latest).*
---

## Environment Setup Instructions

It’s important to isolate your environment to ensure reproducibility. Follow the links below for detailed instructions on environment setup:

- **Python Environment Setup:** [Python Instructions](./resources/environment-instructions/python.md)
- **R Environment Setup:** [R Instructions](./resources/environment-instructions/R.md)
- **Stata Environment Setup:** [Stata Instructions](./resources/environment-instructions/stata.md)

---

## Guidelines


- [Excel Guidelines](./guidance/Excel_Guidelines.md) If your package is in Excel, or includes any component that uses Excel, please review our Excel guidelines.
- [Guide For Flagships](./guidance/step_by_step_flagships.md) If your package is for a Flagship report, please review our Flagship guidelines



[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](./index.html)

