# Isolating programming environments in Stata

These are instructions to make use of Stata's ado folders to create blank-slate programming environments for reproducibility packages.

1. Create a new folder named `ado` where you will store ado files. This should go in the do-files folder if there is one, or in main path of the reproducibilty package if there is no do-files folder
1. Change the `PLUS` ado folder to this ado folder with the command: `sysdir set PLUS "path/to/ado"`. In addition, add this command to the main do-file after creating the path globals and before running any sub do-file
1. Install all external commands. Check the ado folder and verify that they have been installed there
1. If the main do-file installs any external command, delete or deactivate those lines

If you followed these instructions correctly, now your ado folder should include all ado files needed to run the code and the main do-file should change the PLUS ado folder to that location.
There is no need to install any additional commands since all of them should already be included in the ado folder.
