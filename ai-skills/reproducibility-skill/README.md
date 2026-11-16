# Skill: WB Reproducibility Package (Author Edition)

A skill that helps authors prepare a reproducibility package that meets the [World Bank reproducibility standard](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/reproducibility_package_checklist.md) before submitting it for verification.

It is written for **authors**, but it embeds the exact checks the reproducibility team applies as **reviewers**. A package that passes this skill's audit should pass verification on first submission, saving the review round-trips where most calendar time is lost.

Questions: reproducibility@worldbank.org

## Quick start

1. Check which AI tool your data allows (see [Before you start](#before-you-start)).
2. Install the skill in that tool (see [Installation](#installation)).
3. Open your project folder in the tool and say: "Prepare a reproducibility package for this project."

The skill asks about your data first and will not change any file without your approval.

## What it does

The skill runs in five phases (0 to 4) and will not touch your files without approval.

0. **Privacy gate.** Before opening anything, asks how your data is classified and which AI tool you are using. See [Before you start](#before-you-start) for the rules. If your data cannot be shared with the tool, the skill switches to **code-only mode**: it builds the package from your code, manuscript, and README, never opens or runs the data, and you do the final run check on your own machine.
1. **Audit (read-only).** If a manuscript is available, reads it first and scopes the audit to the exhibits it contains. This helps when the project folder has many files unrelated to the paper. Checks the project against the official checklist and 14 common failure flags (hardcoded paths, missing seeds, uninstalled packages, no entry point, extraneous files, and more). Determines which data files your code *produces* and which are *external inputs*, and verifies every external input is documented with source, URL, and access year. Data you collected but have not yet published is marked as forthcoming rather than given a guessed access pathway. Tries to identify common datasets (WDI, PWT, OECD, ILOSTAT, national surveys, and others) and proposes the citation and license status for you to confirm. Classifies each dataset as published with the package, **verification-only** (shared with the reproducibility team but removed before publication because the license does not allow redistribution), or excluded. Checks every data file for PII (the **PII lock**).
2. **Outline (proposes, writes nothing).** A target folder structure (`data/`, `code/`, `output/`), an entry-point plan (one main script per language, with the project path set in exactly one place), and a gap table that serves as the build plan. You approve, edit, or reject each row.
3. **Build (only after approval).** Drafts the README using only the sections required by the template, including the Data Availability Statement and List of Exhibits. Writes the main script(s), applies the approved fixes, and re-runs the audit as a final gate.
4. **Run check.** Sets existing outputs aside and reruns the package from scratch, verifying that every exhibit file regenerates. Where the agent can execute the code (for example R or Python), it runs it and records run times. Where it cannot (for example Stata or MATLAB), it gives you the exact clean-run protocol to run yourself and a reconciliation checklist. The package is ready only when every expected output regenerates.

You do not need a final manuscript to start. The skill builds the exhibit map from your code and outputs and marks what to confirm once the manuscript is final.

## What it does not do

- It never reads confidential data. If your data is not cleared for the tool you are using, it requires a code-only copy of the project and stops if it finds data files in it.
- It never moves, renames, or deletes files without your explicit approval of the specific action.
- It never removes data just because its license is not CC BY 4.0. Data you are licensed to use but not redistribute stays in the package you send to the reproducibility team, with its license recorded and a README note that it will be removed from the published package.
- It will not let data with personally identifiable information (PII) into the package sent to the reproducibility team. It asks you to confirm, for every data file, whether it contains PII. Files that do, or that you have not confirmed, stay out until they are de-identified or are routed to virtual verification.
- It never invents access dates, dataset versions, exhibit numbers, or data-access pathways (NDA, IRB, owning institution). It asks, and marks unpublished data as forthcoming.
- It can only execute code where the runtime is available. For anything it cannot run, Phase 4 gives you the protocol and checklist to run the package yourself.

## Before you start

### 1. Match your data to an allowed tool

| Data classification | Claude | GitHub Copilot (WB enterprise) |
|---|---|---|
| Public, or will be made public with the package | Full mode | Full mode |
| Official Use Only | Code-only mode | Full mode |
| Confidential, Strictly Confidential, or personal data | Code-only mode | Code-only mode |

"Full mode" means the agent may open and run the data. "Code-only mode" means it never sees the data.

### 2. If you are in code-only mode, prepare a clean folder

The skill's rules (never open data, search code files only) are a second layer of protection, not the first. If the data is anywhere the agent can reach, it could still end up in the conversation by accident. So:

1. Make a copy of the project with no data in it. Either run a fresh `git clone`, or copy the project and delete the data, logs, and notebook outputs.
2. On your own machine, run the inventory script from [assets/](https://github.com/worldbank/wb-reproducible-research-repository/tree/update-skill-readme/ai-skills/reproducibility-skill/assets) that matches your language (`data_inventory.do`, `data_inventory.R`, or `data_inventory.py`). Point it at the folder where the data actually lives.
3. Open the resulting `data_inventory.csv` and fill in the blank columns for each dataset: source, URL, access date, and license.
4. Save `data_inventory.csv` into the clean folder.

The inventory lists each data file's hash, size, and variable names, never values. The agent uses it instead of the data to check inputs and draft the Data Availability Statement. It checks the file listing before starting and will not continue until the folder is clean.

## Installation

Download the skill from the [latest release](https://github.com/worldbank/wb-reproducible-research-repository/releases/latest). Alternatively, clone the repository and use the `ai-skills/reproducibility-skill/` folder.

The folder you install must keep its name (`reproducibility-skill`) and have `SKILL.md` directly inside it.

### Claude (web or desktop app)

1. Go to **Settings > Capabilities** and make sure Skills are turned on.
2. Under Skills, upload the release `.zip` without unzipping it.
3. Start a new chat. To work on a project folder directly, use the Claude desktop app and connect the folder.

### Claude Code

Copy the `reproducibility-skill/` folder into one of these locations:

- `<your-project>/.claude/skills/` to use it in one project
- `~/.claude/skills/` to use it in all your projects

Claude Code picks it up the next time you start a session. To confirm, ask "What skills do you have available?"

### VS Code with GitHub Copilot

1. Copy the `reproducibility-skill/` folder into `<your-project>/.github/skills/` (Copilot also reads `.claude/skills/`).
2. Open the Copilot Chat panel and switch to **Agent** mode.
3. If the skill is not picked up, check that agent skills are enabled in your Copilot settings.

### Other agents

Agents that follow the open Agent Skills format usually read skills from `<your-project>/.agents/skills/`. Check your agent's documentation.

### Updating

Download the new release and replace the whole `reproducibility-skill/` folder. Do not merge old and new files.

## Usage

Open your project folder in the agent and type a request in plain language. You do not need to name the skill.

| What you want | What to say |
|---|---|
| The full process (privacy gate, then all phases) | "Prepare a reproducibility package for this project." |
| An audit only, no changes | "Audit this package. What's missing for replication?" |
| A quick check for common failures | "Check this project for common reproducibility failures." |
| The README and Data Availability Statement | "Write the README and data availability statement." |
| A run check on a package that is already built | "Run the clean-run check on this package." |

Every request starts with the privacy gate. Requests for the README still run a short audit first, because the Data Availability Statement depends on how each dataset is classified.

### Tips

- **Work where the agent can see your files.** Results are best in Claude Code, the Claude desktop app with a connected folder, or VS Code with Copilot. In a regular chat with no folder, paste a file listing and your key scripts, and the skill will produce the deliverables for you to place.
- **Add the manuscript** (PDF or Word) to the folder if you have it. The skill uses it to scope the audit to the exhibits in the paper.
- **Review each phase before approving the next.** The outline in Phase 2 is the plan for every change. Edit or reject rows you disagree with.
- **Stata and MATLAB users:** The agent cannot run your code. Expect to run the Phase 4 protocol yourself and report back.

## Contents

```
reproducibility-skill/
├── SKILL.md                         # instructions the agent follows
├── references/
│   ├── checklist.md                 # the official WB package checklist
│   ├── flags.md                     # 14 common failure flags + detection patterns
│   ├── datasets.md                  # common datasets: licenses, redistribution, citations for the DAS
│   └── ai_use.md                    # documenting AI-generated analytical outputs
└── assets/
    ├── README_template.md           # required README structure
    ├── README_example.md            # annotated gold-standard README
    ├── main.do / main.R / main.py   # main script templates
    └── data_inventory.do / .R / .py # values-free data inventory for code-only mode
```

## Maintaining

`references/checklist.md` mirrors the [official checklist](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/reproducibility_package_checklist.md). Update it when the standard changes. `references/datasets.md` records license and redistribution status for common datasets. Review it periodically (last reviewed: July 2026). Contributions via pull request are welcome.

## Contributors

This skill was developed by Impact Analytics and [Ruggero Doino](https://github.com/rdoino-wb).
