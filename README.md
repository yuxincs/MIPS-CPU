# MIPS-CPU

A Simulative CPU Running on MIPS Instruction System Based on Logisim.

### ALU Circuit
##### Description
This ALU is implememted to do 13 operations determined by operator S, with two input X/Y, it can produce result according to the operator S and emit signed and unsigned overflow/Equal signals.
The specific circuit diagram is as below:
##### Overview
  ![#1](https://raw.githubusercontent.com/RyanWangGit/MIPS_CPU/master/Screenshots/ALU_1.png)
##### Adder Circuit with Overflow Detection
  ![#2](https://raw.githubusercontent.com/RyanWangGit/MIPS_CPU/master/Screenshots/ALU_2.png)
  
### Register File
##### Description
This regfile is implemented to simulate the 32 registers running in the MIPS CPU, with the signals passed to it, it can store data into register according to the given register number, and it can direclt load up to two register's data to the port.
##### Overview
  ![#3](https://raw.githubusercontent.com/RyanWangGit/MIPS_CPU/master/Screenshots/RegFile.png)
  
### Single Cycle CPU
##### Description
Fully organized according to the circuit given by `Mars`' `MIPS X-Ray` function to be consistent.
##### Overview
  ![#4](https://raw.githubusercontent.com/RyanWangGit/MIPS_CPU/master/Screenshots/SingleCycleCPU.png)
  
### Pipeline CPU with Bubble Insertion Method
Used `Bubble Insertion` method to prevent data and control hazard.
#### Overview
  ![#5](https://raw.githubusercontent.com/RyanWangGit/MIPS_CPU/master/Screenshots/Pipeline_Bubble.png)

### Pipeline CPU with Data Redirection Method
Used `Data Redirection` method to prevent data hazard, optimized so that it runs less cycles compared to `Bubble Insertion` method.

This pipeline CPU is equipped with a `CP0` which handles exception(interruption), with 3 intteruption source buttons named `ExpSrc0` `ExpSrc1` `ExpSrc2`

The CPU runs into exception mode on clicking one of the buttons, running an exception service program
which displays `2` or `4` or `8` determined by the source number of the clicked button.

The exception service program handles environment protecting, EPC protecting so that CPU surpports multi-level interruption.
#### Overview
   ![#6](https://raw.githubusercontent.com/RyanWangGit/MIPS_CPU/master/Screenshots/Pipeline.png)
   
### Benchmarks
There are various programs for testing the CPU in the `Benchmarks` folder, with a combined final benchmark named `Benchmark.hex`.

All the benchmarks are assembled by `Mars`, a powerful MIPS assembling and debugging tool.
