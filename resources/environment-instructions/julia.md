# Working with Julia in World Bank computers

- Date of this guide: July 17, 2025
- Author: Luise

This is a guide to installing Julia, running code, and reproducing Julia environments in World Bank computers.

## Installing Julia in a WB computer (Windows laptop or VDI)

1. Open the software center application
1. Search `Julia`
1. Install it

After this, you can use Julia by typing `julia` in the terminal or powershell. This will open the Julia REPL (Read-Eval-Print Loop) interface.

## Installing a new Julia version

Julia uses `juliaup` to manage its versions. You can add a new version of Julia with the command: `juliaup add {version-name}`. For example, the command to install version 1.7.4 would be:

```{shell}
juliaup add 1.7.4
```

Once a version its installed, you can select it to be the default version to use with `juliaup default {version-name}`. For version 1.7.4:

```{shell}
juliaup default 1.7.4
```

The complete list of juliaup commands is [here](https://github.com/JuliaLang/juliaup).

## Activating a new environment in Julia

Julia is specifically built to work with environments. You can create a new environment by opening Julia in the command line, pressing the key `]` and entering the command `activate {folder-path}`. This will create an environment with the name of the folder you're pointing at. If you want the environment to have the same name as your current folder, then type:

```{julia}
activate ./
```

You'll note that your environment is active because the terminal prompt will show you the environment name in parentheses, similar to how it is in conda.

## Installing Julia packages

Once your environment is active, install all packages you'll need to run your code. This is done with the command `add {package-name1} {package-name2} ...`. For exmaple, to install the packages `LinearAlg` and `Roots`:

```{julia}
add LinearAlg Roots
```

You can install as many packages as you need after `add ...`.

### Troubleshooting `PyCall`, `PyPlot`, and other Julia packages that interact with Python packages

Julia packages that call Python packages you previously installed with conda are not always directly available. First, you need to tell Julia how to execute any Python code from the terminal, which apparently is not configured by default in Julia's WB installation. To solve this, run this line after opening Julia in the terminal:

```{julia}
ENV["PYTHON"]="python"
```

This will tell Julia that whenever she needs to run Python code or scripts, she should just use the command `python` for it, which is what works in WB computers with an existing conda installation. Once this is done, `PyCall` can be built by running the following code from Julia's REPL, before activating an environment:

```{julia}
import Pkg
Pkg.build("PyCall")
```

## Running Julia scripts

You can run any Julia script from the terminal with:

```{julia}
julia main.jl
```

If you want to select a specific environment in which to run the script, then use:

```{julia}
julia --project=envName main.jl
```

## Reproducing an existing Julia environment

Julia stores the environment information in two files: *Project.toml* and *Manifest.toml*. An explanation of both is [here](https://julialang.github.io/Pkg.jl/v1/toml-files/). In short, *Project.toml* lists the dependencies in a high-level, declaring the project's direct dependencies. *Manifest.toml* records the exact versions of direct and indirect dependencies and contains more details to ensure project reproducibility.

To recreate an existing environment, copy both files to the location where your new project root is. You'll find the files in the root directory of the environment you want to recreate. If you want to recreate Julia's base environment, the they will located at `C:/Users/{User}/.julia/environments/{version}/`. Once they are copied into the new environment root, follow these steps:

1. Open Julia in the command line
1. Press `]` to activate the environment manager
1. Start a new environment in your current folder with `activate ./`
1. Instantiate the environment with the dependencies of the existing environment with `instantiate`

This will start installing all the packages and reproduce the environment.
