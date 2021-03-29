# asm2cfg

GDB Python extension to view and save GDB disassembled function control-flow
graphs (CFG) with simple commands straight from GDB session. To view CFG use
`viewcfg` command and to save it to file use `savecfg` command.

![example](./images/example.png?raw=true "Assembly to CFG")

Program doesn't care about the assembly language. Python will just read the jump
addresses and instructions to determine the control flow from that. Support for
both stripped and non-stripped assembly dumps. Programmed and tested with x86
assembly. So not sure does this work with other assembly languages. If you have
any suggestions or improvements. Please open an issue or file a pull request.


## Table of Content

<!-- vim-markdown-toc GFM -->

* [Prerequisites](#prerequisites)
* [Usage From GDB](#usage-from-gdb)
* [Usage as Standalone](#usage-as-standalone)
  * [Disassembly Function](#disassembly-function)
  * [Draw CFG](#draw-cfg)
* [Test Files](#test-files)

<!-- vim-markdown-toc -->

## Prerequisites

Python 3 is required. If you are using Ubuntu use `pip3` and `python3` commands
instead. Only Python package needed is graphviz. Install it with following.

```
pip install graphviz
```

To view dot files external dot viewer is required. For this purpose
[xdot](https://pypi.org/project/xdot/) can
be used for example. Any other dot viewer will also do. To install this on
Debian based distro run

```
sudo apt install xdot
```

Or Arch based

```
sudo pacman -S xdot
```

Then source `asm2cfg.py` file from this repository to your GDB setup. This makes
it available automatically when you start GDB. To do that make `.gdbinit` file
to your home directory if not already there and place following line it and
modify the path to point to this repository.

```
source <path-to-this-repo>/asm2cfg.py
```

Now when you start GDB you are ready to go.

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

`asm2cfg.py` can also be used as standalone Python program with same
functionality as from GDB with external files. To make this easier for you you
can symlink it to you path first with

```
ln -s <path-to-this-repo> <path-to-your-path-folder>
```

For example `ln -s ~/asm2cfg/asm2cfg.py ~/.local/bin/`.

Run `asm2cfg.py -h` to view the help text of how to use. To use as standalone
script you first need to dump assembly from GDB to the file.

### Disassembly Function

For steps below to work GDB needs to be configured to support pending
breakpoints. To permanently set this add following to your `.gdbinit`.

```
# Don't ask when restarting the application.
set confirm off
# Use pending breakpoints by default.
set breakpoint pending on
```

First disassembly function from your binary file using GDB. You have to know the
function name before hand. To disassembly function named `test_function` from
binary `test_executable` run

```
gdb -ex 'b test_function' -ex 'run' -ex 'pipe disassemble | tee test_function.asm' -ex 'quit' ./test_executable
```

This will set breakpoint at function `test_function`, then
run the program and disassembly the current function where the breakpoint was
set to the file `test_function.asm`.

If you don't know the function name you're looking for then you can also list
all function names using GDB. First set breakpoint at main function and start
the executable you want with

```
gdb -ex 'b main' -ex 'run' ./test_executable
```

Now GDB will break at main function. Now to list all available functions use

```
info functions
```

If you want to narrow the search down you can also use regexp

```
info functions <regexp>
```

Now set breakpoint in the function you want and use `continue` to continue
execution. When breakpoint is hit then disassembly the current function to file
with

```
pipe disassemble | tee <filename>.asm
```

### Draw CFG

Now you have the assembly file. Then time to turn that to CFG. Do that giving it
to Python executable

```
python asm2cfg.py test_function.asm
```

This will output `test_function.pdf` file in the same directory where the
executable was ran. If the assembly file is stripped then function memory range
is used as a name instead. For example `0x555555555faf-0x555555557008.pdf`.

To view CFG instead of saving provide `-v` flag. And to skip function calls from
splitting the code to further blocks provide `-c` flag.

## Test Files

Repository includes examples which can be used to test the standalone
functionality. File `test_function.asm` is non-stripped assembly file and its
corresponding output `test_function.pdf`. File `stripped_function.asm` contains
stripped function and its corresponding output
`0x555555555faf-0x555555557008.pdf`. File `huge.asm` is a large stripped
assembly function its corresponding output `main.pdf`.
