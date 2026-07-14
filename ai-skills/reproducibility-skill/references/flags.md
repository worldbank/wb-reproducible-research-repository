# Common reproducibility failure flags

These are the failures the World Bank reproducibility team encounters most often when verifying packages. The audit in Phase 1 checks every flag below and reports each as PASS, FLAG, or NOT APPLICABLE, with file and line evidence. Detection patterns are given per language; adapt them to the project. A flag is not automatically a failure — it is something the author must fix or explicitly justify in the README.

## Before the flag pass: pre-existing README or main script — presence is not correctness

This is not a flag of its own; it is how the audit treats projects that arrive with a README and/or main/master script already in place (an earlier partial attempt, a hand-written draft, or output from a previous run of this skill). A file existing does not mean it satisfies the checklist or the flags below. Both get the same scrutiny as a project that has neither, and this procedure is mandatory whenever such files predate the audit.

Procedure, cross-checking claims against the actual code:

Run the existing main script(s) through the full F1–F14 pass exactly as if auditing any other code file: an install block existing is not the same as it freezing packages to a project-local folder (F5); a path global existing is not the same as it being the only hardcoded path in the project (F1); a seed appearing somewhere is not the same as it covering every stochastic call (F4).
Verify every script/global/variable name in the README's "Instructions for Replicators" against what the main script(s) actually define. A renamed global or moved file leaves the README describing a step that no longer works — record it against checklist item 3 (README: the exact line(s) to change) as partial or missing.
Verify every row in the "List of Exhibits" points to a script and output filename that actually exist in the code and actually get written (not just plausible-sounding). Mismatches are recorded under F10 / checklist item 3.
Verify the Data Availability Statement lists exactly the external inputs found in the Phase 1 data classification — no more, no less. Drift here is recorded as F8; this cross-check is how F8 gets caught when the README predates a code change.
Verify software versions and package lists named in the README against version statements, install blocks, and lockfiles actually in the code. Mismatches are recorded under F6 (and F5 where installs are involved).


Report each mismatch as its own row under the flag or checklist item it violates: what the README/main script claims vs. what the code actually does, with file and line evidence on both sides. A README that was accurate when written but has drifted from the code is a failure a reviewer will catch even when every flag below passes in isolation.

Fix: update the stale README section or fix the main script so the two are consistent again, following the same author-approval flow as any other fix in Phase 2/3 — never silently rewrite an author's existing README wording beyond what's needed to correct the specific mismatch found.

## F1. Hardcoded user-specific paths outside the main script

Every path pointing to a specific user's machine breaks on the reviewer's machine.

Detect: search all code files for patterns like `C:\Users\`, `C:/Users/`, `/Users/<name>/`, `/home/<name>/`, `D:\`, `Dropbox`, `OneDrive`.
Rule: paths like these may appear at most once, in the main script, on a clearly commented line the README tells the reviewer to change. Any occurrence in a downstream script is a flag.
Fix: single top-level path global/variable in the main script; all other scripts build paths relative to it.

## F2. No single entry point and no documented run order

Detect: no main/master script exists, and the README does not state the order of execution.
Rule: one of the two must hold. One-click (a single main script the reviewer runs after changing one line) is the standard. If genuinely infeasible — e.g., a pipeline that crosses Julia, Python, and Matlab — the README must list the exact run order, including directory changes, with expected run time per step. See `assets/README_example.md` for the model.

## F3. Scattered `cd` / working-directory changes inside analysis scripts

Detect: `cd` (Stata), `setwd(` (R), `os.chdir(` (Python) in any script other than main, or multiple conflicting ones.
Fix: set the working directory once in main; downstream scripts use relative paths or the path global.

## F4. Randomness without a seed

Results will not reproduce numerically.

Detect: use of `bootstrap`, `bsample`, `runiform`, `rnormal`, `sample`, `simulate`, `splitsample` (Stata); `sample(`, `rnorm(`, `runif(`, `kmeans(`, cross-validation calls (R); `np.random`, `random.`, `train_test_split`, `sklearn` estimators with stochastic fitting (Python) — without a preceding `set seed` / `set.seed(` / `np.random.seed(` / `random_state=`.
Also Stata-specific: sorts that precede `_n`-based operations without `set sortseed` or a unique sort key (`isid`). Non-unique sort + `keep if _n==1` is a classic irreproducible pattern.

## F5. User-written packages not installed by code

Detect: commands like `estout`, `esttab`, `outreg2`, `reghdfe`, `ivreg2`, `winsor2`, `grc1leg` (Stata) with no `ssc install` / `net install` in main; `library(x)` with no installation instruction or `renv` lockfile (R); imports with no `requirements.txt` / `environment.yml` / `Project.toml` (Python/Julia).
Fix: main script installs required packages (to a package folder inside the project where possible, so versions are frozen), or the package ships a lockfile / requirements file. Versions matter: record them.

## F6. Software versions not pinned

Detect: README missing software name + version for every language used; Stata scripts missing a `version` statement; Python/R environments unspecified.
Rule: README lists every software and version, including OS and hardware if relevant (e.g., "Tested on MacBook Pro, M-series"). ~35% of verification failures trace to version mismatches of some kind.

## F7. Manuscript–code version mismatch

Applies only when a manuscript is available. At the preparation stage the author may not have a final manuscript — record N/A, and remind them that the manuscript eventually submitted for verification must be the final version and must reflect the final code.

Detect: cannot be fully automated; check that the manuscript in the package is the final version and spot-check that exhibit numbers/values in the manuscript match the code's outputs.
Rule: the verification submission must include the final manuscript, and the code must reflect it. This is the single largest source of verification failures (~35%).

## F8. External input data missing from the Data Availability Statement

This is the data↔README cross-check. Procedure:

1. Inventory every data file in the package (common extensions: .dta, .csv, .xlsx, .xls, .rds, .RData, .parquet, .mat, .json, .txt, .shp and companions).
2. Determine which files the code CREATES, by searching all scripts for write operations:
   - Stata: `save`, `saveold`, `export delimited`, `export excel`, `outsheet`, `putexcel`, `esttab ... using`, `graph export`
   - R: `write.csv`, `write_csv`, `fwrite`, `saveRDS`, `save(`, `write_dta`, `haven::write_*`, `ggsave`
   - Python: `.to_csv`, `.to_excel`, `.to_stata`, `.to_parquet`, `pickle.dump`, `np.save`, `savefig`
   - Julia/Matlab: `CSV.write`, `writedlm`, `save(` (MAT), `writematrix`, `writetable`
3. Classify: a data file written by some script = INTERMEDIATE/OUTPUT (no DAS entry required). A data file never written by any script = EXTERNAL INPUT.
4. Rule: every EXTERNAL INPUT must have a DAS entry with filename, source, URL, access year (and license where known). Any external input absent from the DAS is a flag. Any DAS entry with no corresponding file and no access instructions is also a flag.
5. Reverse check: every file the code READS (`use`, `import delimited`, `read.csv`, `read_dta`, `pd.read_*`, ...) must either exist in the package or be documented in the DAS with access instructions. A read of a file that is neither present nor documented is a flag (the package will crash for the reviewer).
6. Forthcoming or unpublished data: survey or monitoring data the author collected that will be published later (e.g., in the Microdata Library) but is not yet public is common and is not the same as permanently restricted data. Do not describe it with invented pathways like NDA or IRB-approved access, and do not attribute it to an institution unless the author confirms that institution owns it. Instead ask the author to mark it explicitly (e.g., "forthcoming," "planned for release in MDL, not yet available") and record only what the author confirms: intended repository, expected timing if known, and who to contact. If the author hasn't said, leave those fields as an open question rather than inferring a rights or access story — this counts as a DAS entry (satisfies the rule in item 4) even though there is no URL/access year yet.

## F9. Outputs not produced by code

Detect: exhibits in the manuscript with no generating script (search output folders and the exhibit mapping); numbers formatted by hand; Excel files with manual formulas feeding the paper.
Rule: code creates all exhibits and all in-text numbers not drawn directly from tables. Manual steps, where unavoidable, must be documented step-by-step in the README (see the NTM lookup example in `assets/README_example.md` — a documented manual step with source, dropdown selections, and destination file is acceptable; an undocumented one is not).

## F10. Missing List of Exhibits

Detect: README has no exhibit→script→output mapping.
Rule: every table and figure appears in the mapping. If no manuscript exists yet, build the mapping from what the code and outputs reveal (export commands, output filenames like `table1.tex`, `figure_2.png`) and mark rows to confirm against the final manuscript. Non-reproducible exhibits get a stated reason ("non-numerical table", "taken from <citation>"). If not all data is shareable, the list must state which exhibits are reproducible with the materials provided.

## F11. Extraneous files

Detect: data or code not referenced by any script and not needed for any exhibit; project notes; internal communication; `.DS_Store`, `Thumbs.db`, editor backups (`*.bak`, `*~`), old versions (`analysis_v2_FINAL_old.do`).
Rule: the package includes only what reproduction requires. Flag for removal; never delete without approval.

## F12. Absolute output paths / results overwriting inputs

Detect: scripts writing outputs into the raw data folder, or writing outside the project tree.
Rule: raw data is read-only in spirit; outputs go to the outputs tree. A script that overwrites its own input is a flag even if it "works".

## F13. Restricted or sensitive data included by mistake

Detect: files that the DAS or README describe as restricted/confidential but that are physically present in a package destined for publication; personally identifiable variables (names, exact addresses, IDs) in included microdata.
Rule: restricted data is excluded from submissions and handled via NDA, virtual verification, or DDH archiving under restricted access. This flag outranks all others — raise it immediately and prominently.

## F14. Large-compute pathway not documented

Detect: run time plausibly over ~5 days or datasets too large to ship, with no statement of pathway.
Rule: the Artifact Pathway (pre-computed outputs + code + SHA256 checksums) or a "usable data" starting point must be explicit in the README, with provenance and the scripts/protocols that produce the usable data.

## F15. Pre-existing README or main script not verified against current code

Applies whenever a README and/or main/master script already exists in the project before this skill's audit (an earlier partial attempt, a hand-written draft, or output from a previous run of this skill). Presence is not correctness — a file existing does not mean it satisfies the checklist or flags F1–F14; it must be checked with the same rigor as a project that has neither.

Detect, by cross-checking claims against the actual code:
- Every script/global/variable name in the README's "Instructions for Replicators" matches what the main script(s) actually define (a renamed global or moved file leaves the README describing a step that no longer works).
- Every row in "List of Exhibits" points to a script and output filename that actually exist in the code and actually get written (not just plausible-sounding).
- The Data Availability Statement lists exactly the external inputs found in the Phase 1 data classification — no more, no less; an input added to the code later without a matching DAS entry is F8, not F15, but F15 is how it gets caught when the README predates the code change.
- Software versions and package lists named in the README match `version` statements, install blocks, and lockfiles actually in the code.
- Re-run the full F1–F14 pass against the existing main script(s) exactly as if auditing any other code file: an install block existing is not the same as it freezing packages to a project-local folder (F5); a path global existing is not the same as it being the *only* hardcoded path in the project (F1); a seed appearing somewhere is not the same as it covering every stochastic call (F4).

Rule: report each mismatch as its own row — what the README/main script claims vs. what the code actually does, with file and line evidence on both sides. A README that was accurate when written but has drifted from the code is a failure a reviewer will catch even if every individual flag above passes in isolation.

Fix: update the stale README section or fix the main script so the two are consistent again, following the same author-approval flow as any other flag fix in Phase 2/3 — never silently rewrite an author's existing README wording beyond what's needed to correct the specific mismatch found.
