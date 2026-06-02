---
layout: default
title: "Documenting AI Use in a Reproducible manner"
---

[![Back to Home](https://img.shields.io/badge/Back_to-Home-blue)](../index.html)

> *Living document — last updated 05/15/2026. 
> Guidelines are revised periodically as AI tools and documentation standards evolve.*

## 1. Purpose

These guidelines cover ways to improve the reproducibility of AI assisted analytical processes, and how to document use of AI in reproducible research packages. 

Full replication of AI-assisted steps is not possible in the traditional sense. Since large language models are non-deterministic, running the same prompt twice may produce different outputs. 
The goal is therefore **transparency**, not exact replication. We additionally offer guidance on steps to take to improve the reproducibility of AI-assisted processes. 

The standard is: **a reviewer must be able to understand what the AI did, with what inputs, and how the output was validated.** 

Reviewers will **not** re-run prompts. Verification focuses on completeness and consistency of documentation.

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

> **Data sensitivity note:** Do not upload restricted, confidential, or personally identifiable data to commercial AI tools (e.g., ChatGPT, Claude.ai, Gemini). This includes household survey microdata, administrative records, or any data governed by a data use agreement. 
If your analysis involves sensitive data, use only tools approved for that data classification or anonymize/aggregate inputs before use.

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
| **Input data** | Description of any data or documents passed to the model as context, with filenames |
| **Parameters** | Temperature, top-p, max tokens, or other settings if configurable |
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

All AI use documentation must include an **AI Use Statement** in the README. 
For packages with one or few AI-assisted outputs, the full documentation may 
be included directly in the README. For packages with multiple AI-assisted 
outputs, authors are encouraged to create a dedicated `/ai_documentation/` 
folder and reference the relevant log files from the README.

### 4.1 In the README

Include an **AI Use Statement** section in the README file. This section should:

- State which outputs in the knowledge product involved AI tools
- Identify the tool(s) used (name, version, access date)
- Reference the AI documentation log file

**Example:**

> #### AI Use Statement
>The keyword classification in Table 3 was generated using Claude Sonnet 4.6
>(Anthropic, accessed 2025-03-12) via the API. Full prompt text, raw outputs,
and human review notes are documented in 
/ai_documentation/table3_classification_log.md (or section X of this README).


### 4.2 In an AI Documentation Log

If the package includes several AI-assisted outputs, authors may create a 
dedicated log file under `/ai_documentation/`. This keeps the README readable 
while preserving full documentation. The template in Section 5 can be used 
for each log file. Include a dedicated log file in the reproducibility package under `/ai_documentation/`. 

This file must contain the full details from Section 3.

You can use the template provided in Section 5.

---

## 5. Template: AI Documentation Log

Save as `/ai_documentation/documentation_log.md` in your reproducibility package, 
or include directly in README file.

```markdown
# AI Documentation Log

## Output description
[Brief description of what this log covers, e.g., "Keyword classification for Table 3"]

## Publication reference
[Paper title, section, table/figure number where this output appears]

---

## Tool identification

| Field            | Value |
|------------------|-------|
| Tool name        |       |
| Model version    |       |
| Provider         |       |
| Access method    | Web / API / institutional license |
| Access date      | YYYY-MM-DD |
| Prompt language  |       |
| Temperature      |       |
| Other parameters |       |

---

## Inputs

### System prompt
[Paste full system prompt here, or "None"]

### User prompt(s)
[Paste full prompt(s) here. If iterative, include all prompts in sequence. For long multi-turn sessions, export the full chat transcript, save it as a file, and reference it here. If prompts were reconstructed after the fact, note this.]

### Input data or context
[Describe any data or documents passed to the model. Include filenames or paths. If items were processed in batch, specify whether they were sent individually or batched and how many items were processed.]

---

## Outputs

### Raw AI output
[Paste the model's full, unedited response here. For large-scale outputs (e.g., hundreds of classified records), save as a separate file and reference the filename instead of pasting inline.]

### Final output (as it appears in the final product)
[Paste or describe the final version used.]

### Changes from raw to final
[Describe any edits made and the rationale. If no changes, write "None."]

---

## Human review

| Field               | Value |
|---------------------|-------|
| Reviewer name/role  |       |
| Review date         | YYYY-MM-DD |
| Validation criteria | [e.g., checked against source documents, spot-checked 20% of items] |
| Review notes        |       |
```

---

## 6. Questions and Support

For questions about these guidelines or whether your AI use falls within scope, contact the WB Reproducibility Team at reproducibility@worldbank.org.
