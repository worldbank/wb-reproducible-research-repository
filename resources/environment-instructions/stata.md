# Isolating programming environments in Stata

These are instructions to make use of Stata's ado folders to create blank-slate programming environments for reproducibility packages.

### If a main script is present

1. Create a new folder named `ado` inside the code folder.
2. If the README mentions a Stata version, add the version line at the top of the main script:
```stata
   version 18.0 // Replace with the version mentioned in the README
```
3. After the path globals are defined, add the following line to redirect the `PLUS` ado folder to the `ado` folder you created:
```stata
   sysdir set PLUS "${path_to_code}/ado" // Replace with the correct global
```
4. After the `sysdir` line, add the following block to install required packages into the `ado` folder. Replace `xxx` with the required commands. Once installed, you can comment this block out — the packages will persist in the `ado` folder and do not need to be reinstalled on subsequent runs.
```stata
   * Install once, then comment out
   local user_commands xxx xxx  // Replace with required user-written commands
   foreach command of local user_commands {
       cap which `command'
       if _rc == 111 {
           ssc install `command'
       }
   }

   * For packages not available on SSC, use net install, e.g.:
   * net install xxx, from("https://raw.githubusercontent.com/org/repo/main/")
```
5. Check the `ado` folder and verify that all packages have been installed there.

### If a main script is not present

1. If there are only a few do-files and the order in which they should be run is clear from the folder structure or README, create a main script using the [World Bank main.do template](https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/main.do) and follow all steps above.
2. If there are many do-files and the correct order is not immediately clear, ask the authors to create a main script before proceeding.

---

If you followed these instructions correctly, the `ado` folder should contain all packages needed to run the code, and the main script should redirect the `PLUS` ado folder to that location before any sub-scripts are run. There is no need to install any additional commands manually.
