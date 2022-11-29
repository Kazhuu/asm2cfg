
# asm2cfg
![CI status](https://github.com/Kazhuu/asm2cfg/actions/workflows/ci.yml/badge.svg)
[![codecov](https://codecov.io/gh/Kazhuu/asm2cfg/branch/main/graph/badge.svg?token=ZHLOJO8Q3V)](https://codecov.io/gh/Kazhuu/asm2cfg)
[![Total alerts](https://img.shields.io/lgtm/alerts/g/Kazhuu/asm2cfg.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/Kazhuu/asm2cfg/alerts/)
[![Language grade: Python](https://img.shields.io/lgtm/grade/python/g/Kazhuu/asm2cfg.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/Kazhuu/asm2cfg/context:python)

Asm2cfg is a python command-line tool and GDB extension to view and save x86 and
ARM assembly files from GDB, objdump or CSV files as control-flow graph (CFG)
pdf files.
From a GDB debugging session use the `viewcfg` command to view CFG and use
the `savecfg` command to save it to a pdf file.

<p align="center">
  <img src="https://github.com/Kazhuu/asm2cfg/blob/main/images/example.png?raw=true" />
</p>

Asm2cfg has been developed to support X86, ARM, objdump, GDB and CSV assembly
outputs. The program is mostly tested with x86 assembly. ARM, objdump and CSV
formats might not be fully supported. If you have any suggestions or find bugs,
please open an issue or create a pull request. If you want to contribute, check
[Development](#development) how to get started.

## Table of Content

<!-- vim-markdown-toc GFM -->

* [Install](#install)
* [Usage From GDB](#usage-from-gdb)
* [Standalone Usage](#standalone-usage)
  * [Get Function Names](#get-function-names)
  * [Disassemble Function](#disassemble-function)
  * [Draw CFG](#draw-cfgs)
  * [Examples](#examples)
* [Development](#development)
  * [Python Environment](#python-environment)
  * [Testing](#testing)
  * [Code Linting](#code-linting)
  * [Command-Line Interface](#command-line-interface)
  * [GDB Integration](#gdb-integration)
  * [Current Development Goals](#current-development-goals)

<!-- vim-markdown-toc -->

## Install

The project can be installed using pip:

```
pip install asm2cfg
```

To be able to view the dot files from GDB an external dot viewer is required.
For this purpose use e.g., [xdot](https://pypi.org/project/xdot/), but any
other dot viewer will also do.
To install xdot on Debian based distros run:

```
sudo apt install xdot
```

On Arch based systems run:

```
sudo pacman -S xdot
```

To add the extension to GDB you need to source the pip installed plugin. To
find where pip placed the GDB extension run `which gdb_asm2cfg` or if you
use pyenv use `pyenv which gdb_asm2cfg`. Copy the path to the clipboard.

Then in your home directory, if not already there, add the `.gdbinit` file
and place following line in it and replace path from the result from the
previous step.

```
source <path-from-earlier>
```

For example on my Linux machine I end up with the following line:

```
source ~/.local/bin/gdb_asm2cfg.py
```

Now when you start GDB, there should be no errors and you are ready to go.

## Usage From GDB

In the GDB session this extension provides the command `viewcfg` to view the CFG
with an external dot viewer. The command `savecfg` saves the CFG to a pdf file
located in the current working directory with same name as the function being
dumped. Both commands disassemble the current execution frame/function when the
command is issued. To see the help for these commands use the `help` command
e.g, `help viewcfg`.

For example let's view the main function of your favorite non-stripped
executable. First run GDB until main function:

```
gdb -ex 'b main' -ex 'run' <executable>
```

Now run `viewcfg` to view the CFG as a dot graph with an external editor.
Or run `savecfg` to save the CFG as a pdf file named `main.pdf` to current
working directory. If the function is stripped the memory address of the
function will be used as the name instead.
For example `0x555555555faf-0x555555557008.pdf`.

If the assembly function is very large with a lot of jumps and calls to other
functions. Then rendering the CFG can take a long time. So be patient or cancel
rendering with Ctrl-C. To make the rendering faster you can skip function call
instructions from splitting the code into more blocks. To enable this option
run `set skipcalls on` and then run the previous command again. Note that if
the function is long and has a lot of jumps inside itself, then rendering will
still gonna take a long time. To reset to the normal behavior again, run
`set skipcalls off`.

## Standalone Usage

Asm2cfg can also be used on (dis)-assembly files saved from the output of
objdump and GDB. The pip installation comes with the `asm2cfg` command-line
tool for this purpose.

To use as standalone script you first need to dump assembly from GDB or objdump
to the file which is explained below.

### Get Function Names

If you don't know the name of the function you're looking for then you can also
list all function names using GDB:

```
gdb -batch -ex 'b main' -ex r -ex 'info functions' ./test_executable
```

This will set a breakpoint at the function `main`, then
run the program and print symbols from all loaded libraries.

For functions which come from the main executable you can avoid running the
program and simply do:

```
gdb -batch -ex 'info functions' ./test_executable
```

If you want to narrow the search down you can also use regexp:

```
gdb ... -ex 'info functions <regexp>' ...
```

### Disassemble Function

Once you have the function name, you can produce its disassembly via:

```
gdb -batch -ex 'b main' -ex r -ex 'pipe disassemble test_function | tee test_function.asm' ./test_executable
```

Or:

```
gdb -batch -ex 'set breakpoints pending on' -ex 'b test_function' -ex r -ex 'pipe disassemble | tee test_function.asm' ./test_executable
```

(The `set breakpoint pending on` command enables pending breakpoints and
could be added to your `.gdbinit` instead.)

For functions from the main executable it's enough to do:

```
gdb -batch -ex 'pipe disassemble test_function | tee test_function.asm' ./test_executable
```

You can also extract function's disassembly from `objdump` output:

```
objdump -d ./test_executable | sed -ne '/<test_function/,/^$/p' > test_executable.asm
```

(This may be useful for specific non-native targets which lack GDB support.)

### Draw CFGs

Now, with the assembly file, it is time to use asm2cfg to generate a pdf file
containing the CFG. Just give the assembly file to the `asm2cfg`
command-line tool:

```
asm2cfg test_function.asm
```

Asm2cfg by default expects x86 assembly files. If you want to use ARM assembly
files, then provide the `--target arm` command-line flag.

The above command outputs the `test_function.pdf` pdf file in the same
directory. If the assembly file is stripped then the function memory range is
used as a name instead. For example `0x555555555faf-0x555555557008.pdf`.

To view the CFG instead of saving it, provide the `-v` flag. And to prohibit
function calls from splitting the code into further blocks provide the `-c`
flag. To show the help use `-h`.

### Examples

The repository includes examples which can be used to test the standalone
functionality for x86, ARM and objdump.

The file `test_function.asm` is a non-stripped assembly file and its
corresponding output file is `test_function.pdf`.

The file `stripped_function.asm` contains a stripped function and its 
corresponding output file is `stripped_function.pdf`.

The file `att_syntax.asm` is an example of a non-stripped AT&T assembly file.

The file `huge.asm` is a large stripped assembly function and its
corresponding output file is `huge.pdf`. This file can be used to
test the processing time of big functions.

The files `objdump.asm` and `stripped_objdump.asm` are the regular and stripped
objdump-based disassemblies of short functions.

The file `arm.asm` is ARM based assembly file and its corresponding pdf file is
`arm.pdf`.

## Development

You want to contribute? You're very welcome to do so! This section will give you
guidance on how to setup the development environment and test things locally.

### Python Environment

For development this project manages packages with pipenv. Pipenv is a tool to
manage Python virtual environments and packages with much less pain compared to
normal pip and virtualenv usage.

Install pipenv for your system following the guide
[here](https://pipenv.pypa.io/en/latest/).

After installing pipenv. Create a virtual environment and install all required
packages. Run following at the project root:

```
pipenv install -d
```

Now you can activate the virtual environment with:

```
pipenv shell
```

Now your `python` and `pip` commands will correspond to the created virtual
environment instead of your system's Python installation.

To deactivate the environment, use:

```
exit
```

### Testing

This project uses [pytest](https://pypi.org/project/pytest/) for testing. Some
test are written using Python's own unittest testing framework, but they work
with pytest out of the box. The pytest style is the preferred way to write
tests.

To run tests from project root, use `pytest` or:

```
pipenv run pytest
```

During testing the dot viewer might be opened if you have it installed. This is
because the GDB integration command `viewcfg` is tested, which will open
the external dot viewer. Just close it after it's opened. It should not affect
the test itself.

### Code Linting

Project uses [flake8](https://flake8.pycqa.org/en/latest/) and
[pylint](https://pylint.org/) for code linting.

To run flake8, use:

```
flake8
```

And to run pylint use:

```
pylint src test
```

Both commands should not print any errors.

### Command-Line Interface

To test the command-line interface of asm2cfg without installing the package
you can execute the module directly. For example to print the help message:

```
python -m src.asm2cfg -h
```

The standalone method can be used to try out the examples in the `examples`
folder as well. For example the following command should generate the
`main.pdf` file in the current working directory:

```
python -m src.asm2cfg -c examples/huge.asm
```

### GDB Integration

Before testing the GDB functionality, make sure asm2cfg is not installed with
pip! This can lead to GDB using code from the asm2cfg package installed by pip
instead of the code from this repository!

Also pipenv cannot be used with GDB. You need to install the required packages to
your system's python pip. This is because your installed GDB is linked against
your system's python interpreter and will use it, instead of the active virtual
environment. If the packages are not installed to your system's pip you are likely
to receive following error messages when trying to use asm2cfg with GDB:

```
ModuleNotFoundError: No module named 'graphviz'
```

To fix this, install required packages to your system's pip without active
virtual environment. Currently the GDB integration only requires graphviz.

```
pip install graphviz
```

To use the GDB related functionality of asm2cfg. Use following line from
project root:

```
PYTHONPATH=${PWD}/src gdb -ex 'source src/gdb_asm2cfg.py'
```

This will set the python import path so that GDB can import code from this
repository without installing the package. After this you should be able to use
the commands `viewcfg` and `savecfg`.

### Current Development Goals

There are might be cases asm2cfg will not fully support all x86 or ARM assembly
lines. If you encounter such problems please open an issue.

Current developed goals are best described in issues section. Please open a new
one if existing one does not exist.

If you want to talk to me, you can contact me on Discord with name
`Kazhuu#3121`.
