
# asm2cfg
![CI status](https://github.com/Kazhuu/asm2cfg/actions/workflows/ci.yml/badge.svg)
[![codecov](https://codecov.io/gh/Kazhuu/asm2cfg/branch/main/graph/badge.svg?token=ZHLOJO8Q3V)](https://codecov.io/gh/Kazhuu/asm2cfg)
[![Total alerts](https://img.shields.io/lgtm/alerts/g/Kazhuu/asm2cfg.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/Kazhuu/asm2cfg/alerts/)
[![Language grade: Python](https://img.shields.io/lgtm/grade/python/g/Kazhuu/asm2cfg.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/Kazhuu/asm2cfg/context:python)

Python command-line tool and GDB extension to view and save x86, ARM and objdump
assembly files as control-flow graph (CFG) pdf files. From GDB debugging session
use `viewcfg` command to view CFG and use `savecfg` command to save it to the
pdf file.

<p align="center">
  <img src="https://github.com/Kazhuu/asm2cfg/blob/main/images/example.png?raw=true" />
</p>

Program has been developed to support X86, ARM and objdump assembly outputs.
Program is mostly tested with x86 assembly. ARM and objdump formats might not be
fully supported. If you have any suggestions or find bugs, please open an issue
or create a pull request. If you want to contribute, check
[Development](#development) how to get started.

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
  * [Command-Line Interface](#command-line-interface)
  * [GDB Integration](#gdb-integration)
  * [Current Development Goals](#current-development-goals)

<!-- vim-markdown-toc -->

## Install

Project can be installed with pip

```
pip install asm2cfg
```

To be able to view the dot files from GDB. External dot viewer is required. For
this purpose [xdot](https://pypi.org/project/xdot/) can be used for example. Any
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

This method can be used with assembly files saved from ouput of objdump and GDB
disassembly. Pip installation will come with `asm2cfg` command-line tool for
this purpose.

To use as standalone script you first need to dump assembly from GDB or objdump
to the file which is explained below.

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
could be added to your `.gdbinit` instead)

For functions from main executable it's enough to do

```
gdb -batch -ex 'pipe disassemble test_function | tee test_function.asm' ./test_executable
```

You can also extract function's disassembly from `objdump` output:

```
objdump -d ./test_executable | sed -ne '/<test_function/,/^$/p' > test_executable.asm
```

(this may be useful for specific non-native targets which lack GDB support).

### Draw CFG

Now you have the assembly file. Time to turn that to CFG pdf file. Do that by giving it
to `asm2cfg` command-line tool like so

```
asm2cfg test_function.asm
```

Asm2cfg by default expects x86 assembly files. If you want to use ARM assembly files,
then provide `--target arm` command-line flag.

Above command should output `test_function.pdf` file in the same directory where
the executable was ran. If the assembly file is stripped then the function
memory range is used as a name instead. For example
`0x555555555faf-0x555555557008.pdf`.

To view CFG instead of saving provide `-v` flag. And to skip function calls from
splitting the code to further blocks provide `-c` flag. To show the help use
`-h`.

### Examples

Repository includes examples which can be used to test the standalone
functionality for x86, ARM and objdump.

File `test_function.asm` is non-stripped assembly file and its
corresponding output `test_function.pdf`.

File `stripped_function.asm` contains
stripped function and its corresponding output
`0x555555555faf-0x555555557008.pdf`.

File `att_syntax.asm` is an example of non-stripped AT&T assembly.

File `huge.asm` is a large stripped
assembly function and its corresponding output `main.pdf`. This can be used to
test processing time of big functions.

Files `objdump.asm` and `stripped_objdump.asm` are the regular and stripped
objdump-based disassemblies of short functions.

File `arm.asm` is ARM based assembly file and its corresponding pdf file is
`arm.pdf`.

## Development

You want to contribute? You're very welcome to do so! This section will give you
guidance how to setup development environment and test things locally.

### Python Environment

For development this project manages packages with pipenv. Pipenv is a tool to
manage Python virtual environments and packages with much less pain compared to
normal pip and virtualenv usage.

Install pipenv for your system following the guide
[here](https://pipenv.pypa.io/en/latest/).

After installing pipenv. Create virtual environment and install all required
packages to it. Run following at project root

```
pipenv install -d
```

Now you can activate the virtual environment with

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

To run tests from project root, use `pytest` or

```
pipenv run pytest
```

During testing dot viewer might be opened if you have it installed. This is
because GDB integration command `viewcfg` is tested, which will open external
dot viewer. Just close it after it's opened. It should not affect the test run
itself.

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

### Command-Line Interface

To test command-line interface of asm2cfg wihtout installing the package. You
can execute module directly. For example to print help

```
python -m src.asm2cfg -h
```

Standalone method can be used to try out the examples under `examples` folder as
well. For example following command should generate `main.pdf` file to current
working directory.

```
python -m src.asm2cfg -c examples/huge.asm
```

### GDB Integration

Before testing GDB functionality, make sure asm2cfg is not installed with pip!
This can lead to GDB using code from pip installed asm2cfg package instead of
code from this repository!

Also pipenv cannot be used with GDB. You need to install required packages to
your system's Python pip. This is because your installed GDB is linked against
system's Python interpreter and will use it, instead of active virtual
environment. If packages are not installed to your system's pip. You are likely
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

There are might be cases asm2cfg will not fully support all x86 or ARM assembly
lines. If you encounter such problems please open an issue.

Current developed goals are best described in issues section. Please open a new
one if existing one does not exist.

If you want to talk to me, you can contact me at Discord with name
`Kazhuu#3121`.
