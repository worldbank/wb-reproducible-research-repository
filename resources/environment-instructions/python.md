# Isolating programming environments for Python using Conda

These are instructions to create blank-slate programming environments Python reproducibility packages using Conda. They require Anaconda or Conda to be previusly installed.

1. Open the Anaconda terminal
2. Create a new environment with the command: `conda env create --name <env-name> python=3.7`
    + Replace `<env-name>` with your desired environment name
    + You can also specify other versions of Python for the environment. For example: `python=3.10`
3. Accept any prompt you might receive to download or install packages
4. After your environment is created, activate it with `conda activate <env-name>`
5. Install all libraries required for your reproducibility package via conda or pip
    + Conda: `conda install <package-name>=<version>`. For example: `conda install pandas=1.4.1`. You can include multiple package names and versions in a single prompt
    + Pip: `pip install <package-name>==<version>` (notice the double equal sign). You can include multiple package names and versions in a single prompt
    + Not including a version installs the laters version available for the Python version of the environment and OS
    + **Important:** Incompatibilities between packages from conda and pip are a documented problem for Anaconda. This can be avoided by always installing first all packages required from conda and then installing any packages from pip
    + When in doubt between installing a package from conda or pip, use the first. Conda repositories work better for stable and tested versions of packages
6. If you're using a jupyter notebook, keep in mind that conda environments don't automatically work with them. You need to install the packages `notebook` and `nb_conda` to be able to use environments in Jupyter notebooks

Some additional useful commands:
- List all existing environments: `conda env list`
- Deactivate the current environment: `conda deactivate`
- Activate a different environment: `conda activate <name>`
- List all packages installed in your current environment: `conda env export`
- Export your environment metadata in an external file (useful to reproduce environments in new computers): `conda env export > my-env-file.txt`
- Import metadata from an external file to reproduce an environment in your computer: `conda env create --name <env-name> --file my-env-name.txt`
