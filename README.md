
# asm2cfg
![CI status](https://github.com/Kazhuu/asm2cfg/actions/workflows/ci.yml/badge.svg)
[![codecov](https://codecov.io/gh/Kazhuu/asm2cfg/branch/main/graph/badge.svg?token=ZHLOJO8Q3V)](https://codecov.io/gh/Kazhuu/asm2cfg)
[![Total alerts](https://img.shields.io/lgtm/alerts/g/Kazhuu/asm2cfg.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/Kazhuu/asm2cfg/alerts/)
[![Language grade: Python](https://img.shields.io/lgtm/grade/python/g/Kazhuu/asm2cfg.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/Kazhuu/asm2cfg/context:python)

GDB Python extension to view and save GDB disassembled function control-flow
graphs (CFG) with simple commands straight from GDB session. To view CFG use
`viewcfg` command and to save it to a file use `savecfg` command.

<p align="center">
  <img src="https://github.com/Kazhuu/asm2cfg/blob/main/images/example.png?raw=true" />
</p>

Program doesn't care about the assembly language. Python will just read the jump
addresses and instructions to determine the control flow from that. Support for
both stripped and non-stripped assembly dumps. Tested with x86 assembly. So not
sure does this work with other assembly languages. If you have any suggestions
or find bugs, please open an issue or create a pull request. If you want to
contribute, check [Development](#development) how to get started.

## Table of Content

<!-- vim-markdown-toc GFM -->

* [Install](#install)
* [Usage From GDB](#usage-from-gdb)
* [Usage as Standalone](#usage-as-standalone)
  * [Knowing Function Name](#knowing-function-name)
  * [Disassemble Function](#disassemble-function)
  * [Draw CFG](#draw-cfg)
* [Examples](#examples)
* [Development](#development)
  * [Python Environment](#python-environment)
  * [Testing](#testing)
  * [Code Linting](#code-linting)
  * [GDB Integration](#gdb-integration)
  * [Current Development Goals](#current-development-goals)

<!-- vim-markdown-toc -->

## Install

Project can be installed with pip

```
pip install asm2cfg
```

To be able to view the dot files. External dot viewer is required. For this
purpose [xdot](https://pypi.org/project/xdot/) can be used for example. Any
other dot viewer will also do. To install this on Debian based distro run

```
sudo apt install xdot
```

Or Arch based

```
sudo pacman -S xdot
```

To add extension to GDB you need to source the pip installed plugin to it. To
find where pip placed GDB extension run `which gdb_asm2cfg` or in case if you
use pyenv use `pyenv which gdb_asm2cfg`. Copy the path to the clipboard.

Then in you home directory if not already add `.gdbinit` file
and place following line in it and replace path from the earlier step.

```
source <path-from-earlier>
```

For example in my Linux machine line end up to be

```
source ~/.local/bin/gdb_asm2cfg.py
```

Now when you start GDB no errors should be displayed and you are ready to go.

## Usage From GDB

In GDB session this extension provides command `viewcfg` to view CFG with
external dot viewer. Command `savecfg` saves the CFG to pdf file to current
working directory with same name as the function being dumped. Both commands
disassemble the current execution frame/function when the command is issued. To
see help for these commands use `help` command like `help viewcfg`.

For example let's view main function from you favorite non-stripped executable.
First run GDB until main function

```
gdb -ex 'b main' -ex 'run' <executable>
```

Now run `viewcfg` to view CFG as a dot graph with external editor. Or run `savecfg`
to save CFG to pdf file named `main.pdf` to current working directory. If
function is stripped then memory address of the function will used as a name
instead. For example `0x555555555faf-0x555555557008.pdf`.

If assembly function is very large with a lot of jumps and calls to other
functions. Then rendering the CFG can take a long time. So be patient or cancel
rendering with Ctrl-C. To make the rendering faster you can skip function calls
instructions from splitting the code to more blocks. To set this run `set
skipcalls on` and then run earlier command again. Note that if function is long
and has a lot of jumps inside itself, then rendering is still gonna take a long
time. To have normal behavior again run `set skipcalls off`.

## Usage as Standalone

Pip will install `asm2cfg` command-line tool that can be used as a standalone
program with the same functionality as from GDB but with external files.

To use as standalone script you first need to dump assembly from GDB to the file
which is explained below.

### Knowing Function Name

If you don't know the name of function you're looking for then you can also list
all function names using GDB:

```
gdb -batch -ex 'b main' -ex r -ex 'info functions' ./test_executable
```

This will set breakpoint at function `main`, then
run the program and print symbols from all loaded libraries.

For functions which come from main executable you can avoid running the program
and simply do

```
gdb -batch -ex 'info functions' ./test_executable
```

If you want to narrow the search down you can also use regexp

```
gdb ... -ex 'info functions <regexp>' ...
```

### Disassemble Function

Once you have the function name, you can produce its disassembly via

```
gdb -batch -ex 'b main' -ex r -ex 'pipe disassemble test_function | tee test_function.asm' ./test_executable
```

or

```
gdb -batch -ex 'set breakpoints pending on' -ex 'b test_function' -ex r -ex 'pipe disassemble | tee test_function.asm' ./test_executable
```

(the `set breakpoint pending on` command enables pending breakpoints and
could be added to your `.gdbinit` instead).

For functions from main executable it's enough to do

```
gdb -batch -ex 'pipe disassemble test_function | tee test_function.asm' ./test_executable
```

### Draw CFG

Now you have the assembly file. Time to turn that to CFG. Do that by giving it
to `asm2cfg` like so

```
asm2cfg test_function.asm
```

This will output `test_function.pdf` file in the same directory where the
executable was ran. If the assembly file is stripped then the function memory
range is used as a name instead. For example
`0x555555555faf-0x555555557008.pdf`.

To view CFG instead of saving provide `-v` flag. And to skip function calls from
splitting the code to further blocks provide `-c` flag. To show the help use
`-h`.

## Examples

Repository includes examples which can be used to test the standalone
functionality.

File `test_function.asm` is non-stripped assembly file and its
corresponding output `test_function.pdf`.

File `stripped_function.asm` contains
stripped function and its corresponding output
`0x555555555faf-0x555555557008.pdf`.

File `att_syntax.asm` is an example of non-stripped AT&T assembly.

File `huge.asm` is a large stripped
assembly function and its corresponding output `main.pdf`. This can be used to
test processing time of big functions.

## Development

You want to contribute? You're very welcome to do so! This section will give you
guidance how to setup development environment and test things locally.

### Python Environment

For development this project manages packages with pipenv. Pipenv is a tool to
manage Python virtual environments and packages with much less pain compared to
normal pip and requirements.txt file usage.

Install pipenv for your system following the guide
[here](https://pipenv.pypa.io/en/latest/).

After installing pipenv. To create virtual environment and install all required
packages to it, at project root run

```
pipenv install -d
```

Now you can activate the environment with

```
pipenv shell
```

Now your `python` and `pip` commands will correspond to created virtual environment
instead of your system's Python installation.

To deactivate the environment, use

```
exit
```

### Testing

This project uses [pytest](https://pypi.org/project/pytest/) for testing. Some
test are written using Python's own unittest testing framework, but they work
with pytest out of the box. Pytest style is preferred way to write tests.

To run tests use from project root just use `pytest` or

```
pipenv run pytest
```

During testing dot viewer might be opened if you have it installed. This is
because GDB integration command `viewcfg` is tested, which will open external
dot viewer. Just close it after it's opened. It should not affect the test run
results itself.

### Code Linting

Project uses [flake8](https://flake8.pycqa.org/en/latest/) and
[pylint](https://pylint.org/) for code linting.

To run flake8, use

```
flake8
```

And to run pylint use

```
pylint src test
```

Both commands should not print any errors.

### GDB Integration

Before testing GDB functionality, make sure asm2cfg is not installed with pip!
This can lead to GDB using code from pip installed asm2cfg package instead of
code from this repository!

Also pipenv cannot be used with GDB. You need to install required packages to
your system's Python pip. This is because your installed GDB is linked against
system's Python interpreter and will use it instead of active virtual
environment. If packages are not installed to your system's pip. You will likely
to receive following error messages when trying to use asm2cfg with GDB

```
ModuleNotFoundError: No module named 'graphviz'
```

To fix this, install required packages to your system's pip without active
virtual environment. Currently GDB integration only requires graphviz.

```
pip install graphviz
```

To use asm2cfg GDB related functionality. Use following line from
project root.

```
PYTHONPATH=${PWD}/src gdb -ex 'source src/gdb_asm2cfg.py'
```

This will set Python import path so that GDB can import code from this
repository without installing the package. After this you should be able to use
commands `viewcfg` and `savecfg`.

### Current Development Goals

There are known problems that asm2cfg will not fully support all x86 assembly
lines. If you encounter such problems please open an issue.

Also current goal is to improve test coverage and then focus on refactoring the
project to make it easier to add additional assembly support and cover all x86
cases as well. Also objdump support is planned.

If you want to talk to me, you can contact me at Discord with name
`Kazhuu#3121`.
