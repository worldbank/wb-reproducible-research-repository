# Skill: WB Reproducibility Package (Author Edition)

A skill that helps authors prepare a reproducibility package that meets the [World Bank reproducibility standard](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/reproducibility_package_checklist.md) — before submitting for verification.

It is written for **authors**, but it embeds the exact checks the reproducibility team applies as **reviewers**. A package that passes this skill's audit should pass verification on first submission, saving the review round-trips where most calendar time is lost.

Questions: reproducibility@worldbank.org

## What it does

The skill runs in four phases, and it will not touch your files without approval:

1. **Audit (read-only).** Checks your project against the official checklist and 14 common failure flags (hardcoded paths, missing seeds, uninstalled packages, no entry point, extraneous files, ...). Scans your data folder, determines which files your code *produces* vs. which are *external inputs*, and verifies every external input is documented with source, URL, and access year. Tries to identify common datasets (WDI, PWT, OECD, ILOSTAT, national surveys, ...) and proposes the correct citation and license status for you to confirm.
2. **Outline (proposes, writes nothing).** A target folder structure (`data/`, `code/`, `output/`), an entry-point plan (one main script per language, path changed in exactly one place), and a concrete gap table — the build plan. You approve, edit, or reject each row.
3. **Build (only after approval).** Drafts the README (with Data Availability Statement and List of Exhibits), the main script(s), applies the approved fixes, and re-runs the audit as a final gate.
4. **Run check.** Sets existing outputs aside and reruns the package from scratch, verifying that every exhibit file regenerates. Where Claude/AI Agent can execute the code (R/Python in Claude Code or Cowork, Visual Studio, GitHub copilot), it runs it and records run times; where it can't (Stata, Matlab), it gives you the exact clean-run protocol to execute yourself and a reconciliation checklist. The package is ready only when every expected output regenerates.

You do not need a final manuscript to start — the skill builds the exhibit map from your code and outputs, and marks what to confirm once the manuscript is final.

## What it does not do

- It never moves, renames, or deletes files without your explicit approval of the specific action.
- It never invents access dates, dataset versions, or exhibit numbers — it asks.
- It can only execute code where the runtime is available (typically R/Python in Claude Code or Cowork or Visual studio; not Stata or Matlab). For anything it can't run, Phase 4 instructs **you** to run the package on a clean setup and gives you the exact protocol and checklist to confirm every exhibit regenerates.

## Installation

**Claude.ai (web/desktop):** download the `.zip` of this folder, go to Settings → Capabilities → Skills, and upload it. Then start a chat (or a Cowork session with your project folder) and describe what you want.

**Claude Code:** copy the `reproducibility-skill/` folder into your project's `.claude/skills/` directory `.agents/skills/`. Claude/AI agent picks it up automatically.

**VS Code (GitHub Copilot):** copy the `reproducibility-skill/` folder into your project's `.github/skills/` directory or `.claude/skills/`. GitHub Copilot picks it up automatically once agent mode is enabled.

## Usage

Point Claude (terminal or Visual Studio Code) at your project and say something like:

> "Prepare a reproducibility package for this project" — full three-phase run
> "Audit this package / what's missing for replication?" — Phase 1 only
> "Check this project for common reproducibility failures" — Phase 1 flag pass
> "Write the README and data availability statement" — AI agent will still audit first, briefly, because the DAS depends on the data classification

Best results in **Claude Code, Cowork, Visual Studio Code**, where Agent can read your actual project folder. In a regular chat, you can paste a file listing and key scripts, and the skill produces the deliverables for you to place.

## Contents

```
reproducibility-skill/
├── SKILL.md                     # instructions Claude follows
├── references/
│   ├── checklist.md             # the official WB package checklist
│   ├── flags.md                 # 14 common failure flags + detection patterns
│   ├── datasets.md              # common datasets: licenses, redistribution, citations to generate the DAS in the README. 
│   └── ai_use.md                # documenting AI-generated analytical outputs
└── assets/
    ├── README_template.md       # required README structure
    ├── README_example.md        # annotated gold-standard README
    ├── main.do / main.R / main.py  # master script templates
```

## Maintaining

`references/checklist.md` mirrors the [official checklist](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/reproducibility_package_checklist.md); update it when the standard changes. `references/datasets.md` records license and redistribution status for common datasets — review periodically (last reviewed: July 2026). Contributions via pull request are welcome.

## Contributors 

This skill was developed by Impact Analytics and [Ruggero Doino](https://github.com/rdoino-wb). 
