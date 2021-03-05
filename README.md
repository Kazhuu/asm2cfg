# asm2cfg

Python command-line tool to turn GDB disassembled function dumps to control-flow
graphs (CFG). Program doesn't care about the assembly language. Python will just
read the jump addresses and instructions to determine the control flow from
that. Support for both stripped and non-stripped assembly dumps. Tested with x86
assembly. Hopefully works with other assembly too, if not please open an issue
or submit a PR.

![example](./images/example.png?raw=true "Assembly to CFG")

Repository includes example `test_function.asm` for non-stripped assembly file
and corresponding output CFG `test_function.pdf`. Also file
`stripped_function.asm` contains example stripped function and corresponding
output file `0x555555555faf-0x555555557008.pdf`. Notice in case of stripped the
function name is unknown.

## Prerequisites

Python graphviz library is needed. Install that and you are ready to go.

```
pip install graphviz
```

For steps below to work GDB needs to be configured to support pending
breakpoints. To permanently set this make `.gdbinit` file in you home directory
if not already and place following lines in it

```
# Don't ask when restarting the application.
set confirm off
# Use pending breakpoints by default.
set breakpoint pending on
```

## Disassembly Function

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

## Draw Control-flow Graph (CFG)

Now you have the assembly file. Then time to turn that to CFG. Do that giving it
to Python executable

```
python asm2cfg.py test_function.asm
```

This will output `test_function.pdf` file in the same directory where the
executable was ran. If the assembly file is stripped then function memory range
is used as a name instead. For example `0x555555555faf-0x555555557008.pdf`.
