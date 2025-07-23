# Virtual Reproducibility Verification Protocol

This protocol outlines the steps for conducting a **Virtual Reproducibility Verification** session. This approach is used when the reproducibility package relies on strictly confidential data that cannot be shared with the replication team.
During this session, the author executes the full reproducibility package in a clean environment while the reviewer observes virtually. The aim is to ensure that the code runs successfully and produces the expected outputs, all while documenting and preserving a clean and reproducible setup.

---

## 🔁 General Procedure

1. **Schedule a Virtual Session**  
   - The reviewer and author schedule a session via Microsoft Teams (or similar), with screen sharing enabled.

2. **Generate Dataset Hashes (Before Running the Code)**  
   - Use the official [hashing tool](https://github.com/worldbank/wb-reproducible-research-repository/tree/main/resources/generate_hash) provided by the reproducibility team.  
   - To run the tool, authors must have R and RStudio installed on their computer.  
   - Authors can either:
     - Clone the GitHub repository [here](https://github.com/worldbank/wb-reproducible-research-repository/tree/main), or  
     - Download the `generate_hash.zip` file directly from the GitHub page.  
   - After running the tool, a file called `data_hash_report.csv` will be generated.
   - This file must be:
     - Shared with the reviewer during or after the virtual session, and  
     - Included in the final replication package for documentation and verification purposes.

3. **Set Up a Clean Environment**  
   - The author prepares a clean computing environment following instructions from the reproducibility team.  
   - See software-specific instructions in the [Stata Instructions](#stata-instructions) and [R Instructions](#r-instructions) sections below.  

4. **Start Log File** *(Only required if the reviewer cannot observe the full run)*  
   - If the reviewer cannot stay for the full execution, the author must open a timestamp-only log at the beginning of the session to capture:
     - Start and end timestamps  
   - The log **must not** capture any results or sensitive data.  
   - This timestamp log allows the reviewer to verify when the code was executed and cross-check output creation times.
   - If the reviewer observes the entire session and confirms that the package runs successfully, this step is optional.

5. **Run the Reproducibility Package**  
   - The author runs the master script in full, without pausing or editing, unless explicitly agreed upon.
   - The reviewer observes the execution in real time.

6. **Finalize and Share the Results**  
   - If the package runs in **under one hour**, the author shares the following **live during the session**:
     - Outputs (tables, figures, etc.)  
     - Dataset hash file (`data_hash_report.csv`)  
     - Environment file (`ado` folder or `renv.lock`)  
     - Log file with timestamps (optional)  
   - If the package takes **more than one hour**, the author shares these items **after the session**:
     - Output files  
     - Dataset hash file  
     - Environment file  
     - Log file with recorded start and end timestamps 

7. **Post-Session Verification**  
   - The reviewer compares the outputs to the manuscript.  
   - Log timestamps and file creation times are used to confirm that results were generated during the session.  
   - The final reproducibility status and notes are documented and shared with the author.

---

## Stata Instructions

### Master Script Setup

The master `.do` file should include the environment setup at the top, and optional timestamp logging if the reviewer cannot stay for the full session.

```stata
*--- Start of Master Script ---*

* Set clean ado path
sysdir set PLUS "$path/ado"

* Open a plain text log to capture date and time only

global timestamplog "vrv_timestamp_log.txt"
file open log using "$timestamplog", write replace
file write log "Start date and time: `c(current_date)' `c(current_time)'" _n

* Run Master script
* (Do not log outputs)

* Write end timestamp
file write log "End date and time: `c(current_date)' `c(current_time)'" _n

* Close the file
file close log

*--- End of Master Script ---*
```
---

## R Instructions

### Clean Environment and Logging

The author must initialize and lock the environment using `renv`, and record start/end times in a separate text log.

```r
# Start of session
renv::init()
cat("Start date and time:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n", 
    file = "vrv_timestamp_log.txt", append = TRUE)

# Run main scripts here
source("run_all.R")  # or equivalent

cat("End date and time:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n", 
    file = "vrv_timestamp_log.txt", append = TRUE)
    
# After completion
renv::snapshot()

```
- The `renv.lock` file must be shared with the reviewer and included in the final replication package.
- The `vrv_r_log.txt` file should accompany the outputs for timestamp comparison.

---

## ✅ Final Checklist

- [ ] Virtual session completed
- [ ] Dataset hashes generated and shared
- [ ] Scripts run successfully in clean environment
- [ ] Log files with start and end time saved and shared
- [ ] Output files shared and checked
- [ ] Environment lock file (`renv.lock`, or Stata ado folder) shared
- [ ] Reviewer confirms alignment with manuscript