# Creating a Clean R Environment Using `renv`

These are instructions to create blank-slate programming environment for reproducibility packages in R using renv.

## The tool: `renv`
`renv` is a package management tool designed for R, aiding in creating reproducible environments by capturing the state of all packages used in a  R project. This is essential in R programming, where package updates can significantly change code behavior, and user-written packages are frequently updated.

## Step 1: Initialize Your Project
- **New Project:** Create a new R project in RStudio ("File" > "New Project" > "New Directory"), and select the `renv` option.
- **Existing Project:** Integrate `renv` into your existing R project. If the project already has an R project file, skip this step. If not, create a new R project ("File" > "New Project" > "Existing Directory"), go to the directory, and create and open the R project file.

## Step 2: Activate `renv`
- Initiate `renv` in your R project with `renv::init()`.
- This generates important files like `renv/library` and `renv.lock`, tracking your R project's status.

## Step 3: Install Packages
- Use `renv::install()` for package installations, managing package versions effectively and designed to work seamlessly with `renv`.
- In cases where `renv::install()` fails, `install.packages()` can be used as an alternative.

## Step 4: Snapshot Your Environment
- After installing packages and ensuring your code works correctly, use `renv::snapshot()`.
- This updates `renv.lock` with the current status of your R project, crucial for replicating the environment.

## Step 5: Restore Environment
- To replicate an environment already working with `renv`, use `renv::restore()`.
- It relies on `renv.lock` to ensure consistency.

## Step 6: Update Packages
- `renv` helps maintain package versions but may prevent benefiting from bug fixes or improvements. 
- Update packages semi-annually with `renv::update()`, follow the instructions, test your code, then record changes with `renv::snapshot()`.

## Step 7: Clean Up
- Remove unused packages from lengthy projects with `renv::clean()`.

## Caveats and Considerations
- **Version Control:** `renv` automatically creates a `.gitignore` file, which will include in your commit only necessary files for environment replication.
- **R Version:** `renv` stores but does not manage R versions; it's focused on package management.
- **OS Dependency:** `renv` does not manage operating system dependencies.
- **Deactivating `renv`:** If `renv` doesn't suit your needs, deactivate with `renv::deactivate()`. For complete removal, use `renv::deactivate(clean = TRUE)`.

## Additional Resources
- For more information and advanced usage of `renv`, refer to the [official `renv` documentation](https://rstudio.github.io/renv/).



