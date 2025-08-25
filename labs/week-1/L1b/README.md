# Lab 1b: Installation of the CHEME 4/5800 Toolchain (Anaconda, VSCode, Julia, GitHub, etc.)
This lab will walk you through the CHEME 4/5800 toolchain installation. This toolchain includes the following software (all of which are free and open source):

* [Julia](https://julialang.org) - a high-level, high-performance, dynamic programming language that we'll use in the course (along with [Python](https://www.python.org) and other languages such as [C/C++]()) to demonstrate concepts in computational engineering.
* [GitHub Desktop](https://desktop.github.com) - a graphical user interface for the [Git](https://git-scm.com) version control system. We'll use GitHub Desktop to manage the code that we write in the course.
* [Visual Studio Code](https://code.visualstudio.com) - a code editor that supports various programming languages and file formats. We'll use VSCode to write and edit code in the course.
* [Anaconda](https://www.anaconda.com/products/individual) - a Python distribution that includes the [Jupyter Notebook](https://jupyter.org) and [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/) interactive development notebook environments.

__Stretch goal:__ After installing these tools, our stretch goal is to test our installation by working through the L1b test notebook. This will verify that your entire Julia/Jupyter/VSCode/GitHub toolchain is working properly and get you familiar with the notebook format we'll use throughout the course. However, if we don't finish today, we'll do it in the next lab.

Let's go!
___


## Installing Julia
This course uses the [Julia](https://julialang.org) programming language. You can find the installation instructions for Julia [here](https://julialang.org/downloads/). 
We prefer [the **juliaup** version manager](https://github.com/JuliaLang/juliaup) (it manages versions and the `PATH` for you).

**Windows (PowerShell)**

```powershell
winget install -e --id Julia.Juliaup
# then open a NEW PowerShell window
julia --version
```

**macOS (zsh) and Linux (bash/zsh)**

```bash
curl -fsSL https://install.julialang.org | sh
# Restart your terminal (or exec your shell) so PATH updates take effect
julia --version
```

> If you cannot use juliaup, download the Julia installer/tarball [from julialang.org](https://julialang.org/install/) and add the `.../bin` directory to your PATH manually (see below).

Note: some environments or institutional policies disallow piping a remote script directly to `sh`. If that applies to you, download the juliaup installer or the Julia tarball directly from https://julialang.org and follow the manual installation instructions instead.

#### Manual PATH updates
* On `Windows,` please check the `Add Julia to Path` checkbox during installation. This will allow you to run Julia from the command line.
* On `macOS,` please follow the instructions to add Julia to your path found [here](https://julialang.org/downloads/platform/#macos). This will allow you to run Julia from the command line.

## Installing Anaconda
This course uses [Anaconda](https://www.anaconda.com/products/individual) as a Python distribution. You can find the installation instructions for Anaconda [here](https://docs.anaconda.com/anaconda/install/). If you still need a Python installation on your machine, we recommend installing [Anaconda](https://www.anaconda.com/products/individual).  

## Installing Visual Studio Code
This course uses [Visual Studio Code](https://code.visualstudio.com) as a code editor. You can find the installation instructions for Visual Studio Code [here](https://code.visualstudio.com/download). 
* Once you install Visual Studio Code, you must install the [Julia extension](https://www.julia-vscode.org) for Visual Studio Code. You can find the installation instructions for the Julia extension [here](https://www.julia-vscode.org/docs/stable/gettingstarted/).
* You'll also need to install the [Python extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python) for Visual Studio Code. You can find the installation instructions for the Python extension [here](https://code.visualstudio.com/docs/languages/python).
* Once you have installed [Anaconda](https://www.anaconda.com/products/individual), you can install the [IJulia](https://github.com/JuliaLang/IJulia.jl) package, which will allow you to use [Jupyter](https://jupyter.org) with [Julia](https://julialang.org). To do this, open the `Julia REPL` (which you can open by typing `julia` in the terminal window in VSCode) and type the following commands:

```julia
using Pkg
Pkg.add("IJulia")
```

## Installing GitHub Desktop
This course uses [GitHub](https://github.com) to manage our code. You can find the installation instructions for GitHub Desktop [here](https://desktop.github.com). 
* Once you install the GitHub desktop, you can download the labs for the course by clicking on the `Code` button on the [lab GitHub repository](https://github.com/varnerlab/CHEME-5800-Labs-Fall-2025.git) and then clicking on the `Open with GitHub Desktop` button. This will open GitHub Desktop and allow you to download the labs for the course.
* Alternatively, you can copy the URL for the lab and paste it into the URL tab accessible from the `Add > Clone a repository` drop-down box in GitHub Desktop. This will allow you to download the labs into a local directory on your machine.

## Stretch goal: Testing your installation with the L1b Notebook
Once you have installed the software listed above, you can test your installation by working through the `CHEME-5800-L1b-Student-TestNotebook-Fall-2025.ipynb` notebook. This stretch goal will help you:

1. **Verify your complete toolchain** - Make sure your entire Julia/Jupyter/VSCode/GitHub stack is installed and working properly together
2. **Get familiar with notebooks** - The lectures and problem sets will be delivered in notebook format, so it's important to get comfortable working with these interactive documents
3. **Understand the course structure** - The notebook has a structure similar to problem sets and most labs we'll do throughout the course. There's a student version (which initially fails some tests and requires you to make changes) and a solution version for reference

To get started:
1. Open the `CHEME-5800-L1b-Student-TestNotebook-Fall-2025.ipynb` file in VSCode (make sure to have the Jupyter extension installed in VSCode)
2. Let's work through the notebook cells sequentially
3. Run the test suite to see which components need attention
4. Make the necessary changes to get all tests passing

This hands-on approach will give you confidence that your development environment is ready for the course ahead!