# Documenting AI use in a reproducibility package

Source: worldbank/wb-reproducible-research-repository, guidance/AI_reproducibility_guidelines.md (living document, last updated 06/02/2026). Questions: reproducibility@worldbank.org.

## When this applies

Document AI use when an AI tool directly produced an analytical output that appears, directly or transformed, in the knowledge product. Examples: coding or categorizing qualitative responses, thematic groupings or keyword lists, summaries or classifications or structured tables from text, drafted narrative assessments or country profiles or recommendations that appear in the final product, any AI generated result that feeds a finding, table, or exhibit.

Does not apply when AI only helped write or debug code that you then ran. There the script is the auditable output and is already in the package. Disclosing AI coding assistance in the README is encouraged ("Code was developed with the assistance of Claude Code") but not required.

Decision rule: if an AI output appears in the knowledge product, document it. If AI only helped produce code you ran, no extra documentation is required.

Full replication of AI steps is not the goal; models are non deterministic. The standard is transparency: a reviewer must be able to understand what model was used, exactly how it was prompted, and how the output was validated.

Data sensitivity: do not upload Official Use, Confidential, or Strictly Confidential data, partner data that is not open access, or personal data (household microdata, administrative records, anything under a data use agreement) to commercial AI tools. Use only tools approved for that data classification. De-identify or aggregate before analysis where feasible.

## What to record for each in scope output

Tool identification: tool name, model version (be specific; if using the API record the exact snapshot ID such as claude-sonnet-4-6-20251101 rather than an alias), provider, access method (web, API, institutional license), access date, prompt language if not English.

Inputs: full system prompt text (or "None"), full user prompt(s) in sequence (export the transcript for long sessions and reference the file; if reconstructed, say so), input data description with filenames, generation parameters (temperature, top-p, max tokens, or "Not configurable"), processing structure (items sent individually or batched, and how many).

Outputs: the raw unedited model response (save large outputs as a separate file and reference it), the final version that appears in the publication, and any changes between raw and final with the rationale ("None" if unchanged).

Human review: how and by whom the output was reviewed, the validation criteria (for example "spot checked 20% against source documents"), the reviewer name or role, and the review date.

## Where to put it

The README must include an AI Use Statement for each in scope output, covering the full set of fields above somewhere in the package. Pick the format that fits the scale:
- Inline in the README, when there are one or few AI outputs.
- A single package level log (ai_documentation/ai_log.md): shared fields once at the top, a sub-section per output for the specific fields. Reference it from the README. Use when multiple outputs share a setup.
- One log per output (ai_documentation/<output>_log.md): full documentation per file, referenced from the README. Use when outputs differ in tool, model, or setup.

Example AI Use Statement referencing a single log:
> The keyword classification in Table 3 and the country summaries in Annex B were generated using Claude Sonnet 4.6 (Anthropic, accessed 2025-03-12) via the API. Full documentation, including prompt text, raw outputs, and human review notes, is in ai_documentation/ai_log.md.
