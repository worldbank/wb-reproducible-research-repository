---
layout: default
title: "Documenting AI use for Reproducible Research"
---

[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](../index.html)

> *Living document — last updated 06/02/2026. 
> Guidelines are revised periodically as AI tools and documentation standards evolve.*

## 1. Purpose

These guidelines cover ways to improve the reproducibility of AI assisted analytical processes, and how to document use of AI in reproducible research packages. 

Full replication of AI-assisted steps is not possible in the traditional sense. Since large language models are non-deterministic, running the same prompt twice may produce different outputs. 
The goal is therefore **transparency**, not exact replication. We additionally offer guidance on steps to take to improve the reproducibility of AI-assisted processes. 

The standard is: **a reviewer must be able to understand what model was used, exactly how the model was prompted, and how the output was validated.**

Rather than re-running prompts, reviewers will focus on whether the available documentation is sufficient for a third party to replicate the query.

---

## 2. Scope — Documenting AI generated outputs in a reproducibility package

This guideline applies when an AI tool **directly produces an analytical output** that is used in a knowledge product. Examples include using AI for:

- Categorizing or coding qualitative responses
- Generating thematic groupings or keyword lists
- Producing summaries, classifications, or structured tables from text data
- Drafting narrative assessments, country profiles, or reform recommendations that appear in the final product
- Generating structured action plans or diagnostic outputs used in the knowledge product
- Any AI-generated result that feeds directly into a finding, table, or exhibit

This guideline does not apply when AI was used as a coding assistant to help write or debug scripts (e.g., using GitHub Copilot or Claude to write Stata or Python code). In those cases, the script itself is the auditable output and is already required to be included in the package. 
Researchers are encouraged to disclose the use of AI coding tools in their README (e.g., "Code was developed with the assistance of GitHub Copilot/Claude Code"), though this is not a strict requirement.

> **Decision rule:** If an AI output appears, directly or transformed, in the knowledge product, document it. If AI only helped produce code that you then ran, no additional documentation is required.

> **Data sensitivity note:** Do not upload Official Use, Confidential, or Strictly Confidential data, any data acquired from partners that is not open access, and/or any personal data to commercial AI tools (e.g., ChatGPT, Claude.ai, Gemini). This includes household survey microdata, administrative records, or any data governed by a data use agreement. 
If your analysis involves sensitive data, use only tools approved for that data classification. A first step of of de-identifying, aggregating, or stripping sensitive data data before the analysis is recommended where feasible and may allow for use of a broader set of tools for the analysis.

---

## 3. What to Document

For each in-scope use of an AI tool, authors must record the following:

### 3.1 Tool Identification

| Field | What to record |
|---|---|
| **Tool name** | e.g., ChatGPT, Claude, Gemini, Copilot, NotebookLM |
| **Model version** | e.g., GPT-4o, Claude Sonnet 4.6, Gemini 1.5 Pro — be specific; outputs differ across versions. If using the API, record the exact model snapshot ID (e.g., `claude-sonnet-4-6-20251101`) rather than an alias, as aliases can silently update |
| **Provider** | e.g., OpenAI, Anthropic, Google |
| **Access method** | Web interface, API, or institutional license |
| **Access date** | Date(s) on which the tool was used to generate the output |
| **Language** | Language in which prompts were written, if not English |

### 3.2 Inputs

| Field | What to record |
|---|---|
| **System prompt** | Full text of any system-level instructions given to the model (or "None") |
| **User prompt(s)** | Full text of all prompts used. If iterative, include all prompts in sequence. For long multi-turn sessions, export and save the full chat transcript as a file and reference it here. If prompts were not recorded in real time, reconstruct them as faithfully as possible and note that they are reconstructed |
| **Input data** | Description of any data or documents passed to the model as context, with filenames. Any input files that are not publicly accessible should be included in the reproducibility package where permissible; at minimum, provide full citations or documentation for all inputs. |
| **Parameters** | Record any configurable generation settings: **Temperature** (typically 0–2) controls randomness — lower values yield more consistent outputs, higher values more varied; **Top-p** (0–1) sets the nucleus sampling threshold; **Max tokens** caps the response length. These settings are found in API call parameters, the platform's settings panel, or the system configuration. If using a web interface that does not expose these settings, write "Not configurable." |
| **Processing structure** | If the AI was applied to multiple records (e.g., classifying 500 survey responses): specify whether items were sent individually or batched, and how many items were processed |

### 3.3 Outputs

| Field | What to record |
|---|---|
| **Raw AI output** | The model's full, unedited response. For large-scale outputs (e.g., hundreds of classified records), save as a separate file (e.g., a CSV) and reference the filename here rather than pasting inline |
| **Final output** | The version that appears in the publication |
| **Changes** | Any edits made between raw and final output, and the rationale. If none, write "None." |

### 3.4 Human Review

| Field | What to record |
|---|---|
| **Review process** | How and by whom the AI output was reviewed |
| **Validation criteria** | What standards were applied (e.g., "spot-checked 20% against source documents") |
| **Reviewer** | Name or role of the person(s) who reviewed the output |
| **Review date** | Date review was completed |

---

## 4. Documentation Format

The README must include an **AI Use Statement** for each in-scope AI output. This statement must cover the full set of information described in Section 3. Authors can choose how to organize that documentation — pick the format that fits the scale and structure of the package:

- **Inline in the README:** Include the Section 3 documentation directly under the AI Use Statement. Suitable when there are one or few AI-assisted outputs.
- **Single AI documentation log** (`/ai_documentation/ai_log.md`): Create one package-level log file. Document any fields shared across outputs (e.g., tool, model version, system prompt) once at the top, then add a sub-section per output covering the output-specific fields (user prompt, input data, raw output, validation). Reference this file from the README. Recommended when multiple outputs share a common setup.
- **Separate log per output** (e.g., `/ai_documentation/table3_classification_log.md`): Create one log file per output, each containing the full Section 3 documentation for that output. Reference each file from the README. Recommended when outputs differ substantially in tool, model, or setup.

In any of the cases, the documentation must include the full set of fields in Section 3 somewhere in the package.

**Example AI Use Statement (referencing a single log file):**

> #### AI Use Statement
> The keyword classification in Table 3 and the country summaries in Annex B
> were generated using Claude Sonnet 4.6 (Anthropic, accessed 2025-03-12) via
> the API. Full documentation — including prompt text, raw outputs, and human
> review notes — is in `/ai_documentation/ai_log.md`.

---

## 5. Questions and Support

For questions about these guidelines or whether your AI use falls within scope, contact the WB Reproducibility Team at reproducibility@worldbank.org.

