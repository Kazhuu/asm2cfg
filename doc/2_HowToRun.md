# How to Run

## As python module

```cmd
python3 -m ocgraph -f a.out  -d objdump -a sparc -c cov.csv -o a.pdf
```

## As command line script

```cmd
./asm2cfg -f a.out -d objdump -a sparc -c cov.csv -o a.pdf
```

## Custom python script

```python
from ocgraph.interface.analyzer import Analyzer
from ocgraph.interface.drawer import Drawer
from ocgraph.interface.coverage_reader import CoverageReader

from ocgraph.coverage_tracer import CoverageTracer
from ocgraph.configuration.configuration import CovTraceConfiguration

# Create configuration
config = OcGraphConfiguration(disassembler="objdump", arch="sparc")

# Read input text
lines = read_lines("a.out")

# Analyze input text
analyser = Analyzer(config=config)
analyser.parse_lines(lines=lines)

# Update analyzed input with coverage data
cov_reader = CoverageReader(instructions=analyser.instructions config=config)
cov_reader.update_by_csv(args.coverage)

drawer = Drawer(analyser.configuration)
drawer.draw_cfg(name=analyser.function_name, basic_blocks=analyser.basic_blocks, output="a.pdf")
```
