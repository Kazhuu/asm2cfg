
# asm2cfg
![CI status](https://github.com/Kazhuu/asm2cfg/actions/workflows/ci.yml/badge.svg)
[![codecov](https://codecov.io/gh/Kazhuu/asm2cfg/branch/main/graph/badge.svg?token=ZHLOJO8Q3V)](https://codecov.io/gh/Kazhuu/asm2cfg)

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
or improvements. Please open an issue or create a pull request.

## Table of Content

<!-- vim-markdown-toc GFM -->

* [Install](#install)
* [Usage From GDB](#usage-from-gdb)
* [Usage as Standalone](#usage-as-standalone)
  * [Knowing Function Name](#knowing-function-name)
  * [Disassemble Function](#disassemble-function)
  * [Draw CFG](#draw-cfg)
* [Examples](#examples)

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
