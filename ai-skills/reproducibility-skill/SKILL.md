---
name: wb-reproducibility-package
description: Help an author prepare a complete World Bank reproducibility package from an existing research project (Stata, R, Python, Julia, Matlab, or mixed). Use whenever the user wants to organize or restructure project files for replication, build or check a replication package, write a replication README or data availability statement, set up a main/master script, check for common reproducibility failures, or asks "is this package complete", "what is missing for replication", "flag reproducibility issues", or "package this for submission". Use it even when the user only describes the goal (getting a paper's code and data ready for others to rerun) without naming the standard. The package this skill produces should pass World Bank reproducibility verification on first submission.
---

# World Bank reproducibility package (author edition)

This skill helps an author turn an existing project — code, data, outputs, in whatever state — into a reproducibility package that meets the World Bank standard on first submission. It is written for authors, but it embeds the exact checks the reproducibility team applies as reviewers, so passing this skill's audit and update the exhibits to this version means passing verification.

It runs in four phases with a stop point between each: audit (read-only), outline (proposes), build (after approval), and run check (prove it runs and regenerates every exhibit). Do not skip phases and do not move or write files before the user approves the outline in Phase 2.

Two references are the authority — read them, do not rely on memory:
- `references/checklist.md`: the official package requirements (what must be present).
- `references/flags.md`: the common failure flags reviewers check (what must not be broken).

## Operating principle

The audit is read only. Phases 1 and 2 report and propose; they never move, rename, delete, or overwrite a file. A package breaks when a file a script references by path is moved silently, so destructive actions wait for explicit sign-off in Phase 3. If the user asks to "just fix everything" before seeing the outline, offer the outline first, then build.

If you are in Cowork or another setting with file access, act on the real project folder in Phase 3. In chat without file access, Phase 3 produces the deliverables (README, main script, restructure plan, flag-fix list) for the user to place themselves.

## Phase 1: Audit

Goal: report the current state against the standard. Change nothing.

1. Read `references/checklist.md` and `references/flags.md`.
2. Locate the project (ask for the path or repo if not provided) and locate the manuscript (tex/docx/pdf). If a manuscript exists, read it before inventorying anything else and use it to scope the audit: the set of exhibits it contains (tables, figures, in-text numbers) defines what is in scope. In a messy project folder with unrelated files, data, or outputs, do not inventory everything indiscriminately — inventory against the manuscript's exhibit list first, then trace backward from each exhibit to its generating script and that script's inputs. Files never touched by that trace (extra datasets, superseded output versions, unrelated sub-projects sharing the folder) are out of scope for this package; note them as excluded, do not fold them into the checklist or outline. If no manuscript exists yet, say so and fall back to inventorying everything, flagging that the exhibit scope cannot be pinned down until a manuscript is provided.
3. Inventory everything in scope: data files, code files, outputs, README, manuscript, license.
4. Identify language(s) and run structure: is there a main script, what order do scripts run in, are paths hardcoded or set through a single top-level global? If a main script and/or README already exist — from an earlier partial attempt, a hand-written draft, or a previous run of this skill — do not take their presence as sufficient. They get the same scrutiny as a project with neither: run them through the full checklist and flag pass below, and apply the "pre-existing README or main script" procedure at the top of references/flags.md to cross-check the README's specific claims against what the code actually does, reporting each mismatch under the checklist item or flag it violates.
5. Checklist pass. Check every item in `references/checklist.md`; record present / partial / missing with filename or line as evidence. "Present" means verified against its actual content, not merely that the file exists.
6. Flag pass. Check every flag F1–F14 in references/flags.md; record PASS / FLAG / N/A with evidence. Run the detection patterns given there (grep for hardcoded paths, seeds, install commands, write operations, and so on) rather than eyeballing. If a main script or README predates this audit, the pre-existing-README/main cross-check at the top of that file is not optional — run it in full alongside the flag pass, and file its findings under the flags and checklist items they violate.
7. Data↔README cross-check (flag F8, run it in full), scoped to the data actually feeding in-scope exhibits (step 2). Classify each in-scope data file as EXTERNAL INPUT (never written by any script) or INTERMEDIATE/OUTPUT (written by some script). Every external input must appear in the Data Availability Statement with filename, source, URL, and access year, or be marked forthcoming per F8 item 6 (data collected but not yet published — never invent an access pathway for it). Intermediates need no DAS entry. Also run the reverse check: every file the code reads must exist in the package or be documented with access instructions. Report the classification as a table: file, classification, written by (script or "—"), in DAS (yes/no), status.
   For each external input, attempt identification against `references/datasets.md` (guess-and-confirm): match on filename patterns and variable names, report confidence (LIKELY / POSSIBLE / UNKNOWN), and propose the DAS entry and citation from that reference for the author to confirm — never fill in access dates, versions, or vintages the author has not confirmed. An external input with UNKNOWN provenance is a blocking question to the author, not a footnote. Never guess an access pathway (NDA, IRB, virtual verification, an owning institution) that is not in this reference or confirmed by the author — ask instead.
8. Exhibit coverage. Build the exhibit map by starting from the manuscript's exhibit list (step 2) and matching each to its generating script and output file (export commands, output filenames like `table1.tex`, `figure_2.png`, comments and labels). If no manuscript exists yet, build the map from the code and outputs instead, and note that the exhibit-by-exhibit check happens once the manuscript is final, and that the submitted manuscript must reflect the final code (~35% of verification failures are version mismatches).

Output: (a) the checklist status table, (b) the flag table, (c) the data classification table, (d) the exhibit coverage table. Keep it factual; do not propose fixes yet.

Then stop. Tell the user the audit is complete and ask whether to proceed to the outline. Do not continue in the same turn.

## Phase 2: Outline

Goal: propose the target package and the work to get there. Write nothing to the project.

Produce three artifacts.

1. Target structure. Whenever possible the package uses the standard three-folder tree at the top level:

   ```
   data/     (raw and cleaned inputs; raw is treated as read-only)
   code/     (main script(s) at the top, then numbered stages: 01_cleaning, 02_analysis, ...)
   output/   (tables and figures, main and annex)
   ```

   Show where each existing file maps into this tree and where new files belong. Use the project's existing conventions where they already meet the standard; do not impose renames the standard does not require — but do propose the three-folder tree when the current layout scatters data, code, and outputs together.

2. Entry-point decision. The rule: the replicator changes a path in exactly one place per language, at the top of a main script — never inside downstream scripts. State explicitly which pattern applies:
   - One language → one main script (templates: `assets/main.do`, `assets/main.R`, `assets/main.py`) that sets the single path global, installs packages, sets seeds, and runs everything. True one-click.
   - Multiple languages → one main script per language (e.g., `main.do` + `main.py` + `main.m`), each with its own single top-level path line, run in an order the README states explicitly with expected run time per step. `assets/README_example.md` shows the model.
   Either way, no path edits anywhere except the top of the main script(s). The outline must name which pattern applies and why.

3. Gap table. One row per checklist gap and one per flag from Phase 1. Columns: item/flag, required, present now, action to close. Actions are concrete: "add DAS entry for OECD_self_employment.xlsx with URL and access year", "move the three hardcoded paths in 2_event_study.do into the path global in main.do", "add set seed 12345 before bootstrap in 04_inference.do". This table is the build plan.

Then stop. Present the outline and ask the user to approve, edit, or reject specific rows. Revise and re-present if asked. Do not start Phase 3 until the user approves.

## Phase 3: Build

Goal: assemble the package per the approved outline. Only after approval.

Work through the approved gap table row by row.

- README: draft from `assets/README_template.md`, at the level of specificity shown in `assets/README_example.md`. Fill only the sections the template marks as required (Overview, Data Availability, Instructions for Replicators, List of Exhibits, Requirements). Do not add sections beyond the template (e.g., "Key Specifications," "Troubleshooting," "FAQ," "Regression Specifications") unless the user explicitly asks for them — the template's own optional sections (Code Description, Folder Structure) are the only extras to consider, and only when they add real information. The Overview accounts for every exhibit, including the ones the package does not reproduce, each with its reason. Instructions state the exact line(s) to change and expected run times where known (ask the user for run times; do not invent them).
- List of Exhibits: map every identifiable table and figure to output filename and generating script (and line where useful). Build it from the manuscript's exhibit list first (Phase 1 step 2); fall back to code and outputs only if no manuscript exists yet, and leave clearly marked placeholder rows for exhibits to confirm against the final manuscript. Never invent exhibit numbers or filenames — if a mapping is unknown, mark the row and ask. If not all data ships with the package, state which exhibits are reproducible with the material provided.
- Data availability statement: classify (all public / some restricted / none public). For each external-input dataset (from the Phase 1 classification): filename, source, URL, access year, license where known, and step-by-step access instructions if restricted. Use the confirmed identifications and citation formats from `references/datasets.md` — never invent a rights statement, NDA pathway, IRB claim, or owning institution that the author hasn't confirmed or that isn't backed by `references/datasets.md`. For forthcoming/unpublished data, apply flags.md F8 item 6: state it is not yet published, name the intended repository if the author has confirmed one, and leave access mechanics as an open question rather than fabricating one. Include the rights statement only with wording the author confirms. For genuinely restricted data, note only the pathways the author confirms apply (e.g., NDA, virtual verification, DDH restricted archiving) — do not list all three by default.
- Main script: draft from `assets/main.do` / `assets/main.R` / `assets/main.py`. Version statement, single path global, package installation, seeds, then the analysis scripts in order. Preserve the project's existing script and object names verbatim. For Stata specifically, carry over the template's `sysdir set PLUS` line (pointed at a project-local folder, e.g. `code/ado`, created with `cap mkdir` if missing) *before* the install loop — do not let `ssc install` fall through to the replicator's personal ado directory, since packages installed there aren't shipped with the package and aren't frozen to the versions the author used (see flags.md F5). This line is easy to drop when adapting the template to a project's own globals; check for it explicitly when reviewing the drafted main script, not just that an install block exists.
- No new names. Keep every existing output filename exactly as the code already writes it (`figure1.png` stays `figure1.png`, not `fig_01.png`), and do not edit export/save/ggsave/savefig filenames in the code. Renaming an output creates a duplicate: the old file lingers, the new one appears, and the exhibit mapping no longer matches what a rerun produces. The List of Exhibits maps to the names the code writes — the mapping adapts to the code, never the other way around. The same goes for data files and scripts: changing where a file *lives* (approved moves into the target tree) is allowed; changing what it is *called* is not, unless the user explicitly asks for a rename, in which case update every reference to it in the same pass and confirm nothing else reads the old name.
- Flag fixes: apply each approved flag fix (seeds, path globals, install blocks, removing extraneous files). After any file move, check that no script's path reference breaks.
- AI use: if any analytical output in the paper was produced by an AI tool (not just code assistance), add an AI Use Statement per `references/ai_use.md`. Read that file only when this is in scope.

When done, report what was created or changed, and rerun the Phase 1 checklist and flag passes as a final gate so the user sees the closed state. Flag anything still open (restricted data that cannot ship, exhibit mappings awaiting confirmation, run times to be filled in after a clean run). Then proceed to Phase 4.

## Phase 4: Run check

Goal: prove the package actually runs end to end and regenerates every exhibit. A package that audits clean but has never been run from scratch is not done.
0. Before starting the process give the user the option to run the check themselves on their own machine, and provide the checklist for them to follow. If they choose to do so, skip steps 1–7 and go straight to step 8.
1. Snapshot expected outputs. From the List of Exhibits, build the list of every output file the code should produce (tables, figures, intermediate datasets the pipeline creates).
2. Clear or set aside existing outputs. Rename the output folder (e.g., `output/` → `output_old/`) or move generated files aside — never delete without approval. Regenerating into an empty output tree is the only honest test; outputs left over from earlier runs mask failures.
3. Run what the environment allows. If you have execution access (Claude Code, Cowork) and the language runtimes are available (R, Python, Julia), run the main script(s) in the documented order, exactly as the README tells a replicator to — fresh start, change only the designated path line(s). Capture errors verbatim. Stata and Matlab typically cannot run in these environments; say so plainly rather than pretending, and cover them via step 5.
4. Verify outputs, not just exit codes. After each stage, check that every expected file from step 1 now exists with a fresh timestamp and is non-empty (non-zero size; figures open; tables contain rows). Record run time per stage and put it in the README. A script that finishes silently but writes nothing is a failure.
5. Author run-check protocol for what could not be executed. Give the author the exact same procedure to run on their machine, as a checklist: (i) fresh copy of the package in a new location (this catches paths pointing at the old project), (ii) change only the designated line(s), (iii) run the main script(s) in README order, (iv) confirm every file on the expected-output list regenerates with a new timestamp, (v) record per-stage run times into the README, (vi) if any exhibit file does not regenerate, the package is not ready — fix and rerun. Recommend doing this on a machine or account that is not the author's usual setup where possible.
6. Reconcile. Compare regenerated outputs against the previous ones (`output_old/`): same filenames, same dimensions, and — where the code is seeded — same numbers. A regenerated file with a different name than before is itself a failure (something renamed an output; see the no-new-names rule in Phase 3). Differences in stochastic results despite seeds are a flag (see F4). Report the reconciliation table: expected file, regenerated (yes/no), matches previous (yes/no/approx), run time.
7. Clean up. Once reconciliation passes, the set-aside `output_old/` folder must be removed (with the user's approval) so the package ships exactly one copy of each exhibit — the regenerated one. Never submit with both.
8. Only after the run check passes (or the author confirms their local run passed) is the package ready for submission.
9. Tell the author if they are ready to submit to remember to update the manuscript to this version of the outputs. Version control is the most common source of verification failures, so the manuscript must match the outputs the package produces. 

## What the package must not contain

See flag F11: code or data not needed for the paper's results, project notes, internal communication, editor droppings. Flag in the audit; deletion waits for approval.

## Reference files

- `references/checklist.md`: official requirements. Read at the start of Phase 1.
- `references/flags.md`: common failure flags with detection patterns. Read at the start of Phase 1.
- `references/datasets.md`: common datasets with licenses, redistribution status, and citation formats, for guess-and-confirm identification of external inputs. Read during the Phase 1 data cross-check.
- `references/ai_use.md`: documenting AI-produced analytical outputs. Read in Phase 3 only if in scope.
- `assets/README_template.md`: the README structure to draft from.
- `assets/README_example.md`: annotated gold-standard README showing the target level of specificity.
- `assets/main.do`, `assets/main.R`, `assets/main.py`: master script templates.
