# MIPS-CPU

A Simulative CPU Running on MIPS Instruction System Based on Logisim.

![MIPS-CPU-GIF](https://user-images.githubusercontent.com/10323518/31847758-7194fee4-b5ef-11e7-8d66-48773d4e3897.gif)

Two categories of CPU are implemented in this repository for learning purposes:

* **Single Cycle CPU:** Each instruction takes exactly one CPU cylcle to finish.

* **Pipelined CPU:** A five-stage pipelined CPU. There are two versions for solving the [hazards](https://en.wikipedia.org/wiki/Hazard_(computer_architecture)) introduced by pipelining: 

  1. [Pipeline Bubbling](https://en.wikipedia.org/wiki/Hazard_(computer_architecture)#PIPELINE-FLUSH) for all hazards. 

  2. Based on Pipeline bubbling, [Operand Forwarding](https://en.wikipedia.org/wiki/Operand_forwarding) is used for data hazards to reduce the total number of pipeline stalls for better performance.

## Supported Instructions
Only a subet of the MIPS instruction set is supported:

**Instruction**|**Format**|**Instruction**|**Format**
:-----:|:-----:|:-----:|:-----:
Add|add $rd, $rs, $rt|Store Word|sw $rt, offset($rs)
Add Immediate|addi $rt, $rs, immediate|Branch on Equal|beq $rs, $rt, label
Add Immediate Unsigned|addiu $rt, $rs, immediate|Branch on Not Equal|bne $rs, $rt, label
Add Unsigned|addu $rd, $rs, $rt|Set Less Than|slt $rd, $rs, $rt
And|and $rd, $rs, $rt|Set Less Than Immediate|slti $rt, $rs, immediate
And Immediate|andi $rt, $rs, immediate|Set Less Than Unsigned|sltu $rd, $rs, $rt
Shift Left Logical|sll $rd, $rt, shamt|Jump|j label
Shift Right Arithmetic|sra $rd, $rt, shamt|Jump and Link|jal label
Shift Right Logical|srl $rd, $rt, shamt|Jump Register|jr $rs
Sub|sub $rd, $rs, $rt|Syscall（Display or Exit）|syscall
Or|or $rd, $rs, $rt|Move From Co-processor 0|mfc0 $t0,$12
Or Immediate|ori $rt, $rs, immediate|Move To Co-processor 0|mtc0 $t0,$12
Nor|nor $rd, $rs, $rt|Exception Return|eret
Load Word|lw $rt, offset($rs)| | 


Refer to [Quick Reference](https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00565-2B-MIPS32-QRC-01.01.pdf) and [Complete Instruction Manual](https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00086-2B-MIPS32BIS-AFP-6.06.pdf) for complete specifications.


## Single Cycle CPU
#### Description
Organized according to the circuit given by `MIPS X-Ray` of `Mars` for better understanding.
#### Overview
  ![singlecyclecpu](https://cloud.githubusercontent.com/assets/10323518/24080239/d1bd5ae6-0cd5-11e7-927d-a2b877a9b139.png)
  
## Pipeline CPU (Pipeline Bubbling)
Used `Pipeline Bubbling` to prevent data and control hazard.
### Overview
  ![pipeline_bubble](https://cloud.githubusercontent.com/assets/10323518/24080238/d1bc1910-0cd5-11e7-8c7c-f3de3d97a30b.png)

## Pipeline CPU (Operand Forwarding)
Used `Operand Forwarding` method to prevent data hazard, optimized so that it runs less cycles compared to `Bubble Insertion` method.

This pipeline CPU is equipped with a `CP0` which handles exception(interruption), with 3 intteruption source buttons named `ExpSrc0` `ExpSrc1` `ExpSrc2`

The CPU runs into exception mode on clicking one of the buttons, running an exception service program
which displays `2` or `4` or `8` determined by the source number of the clicked button.

The exception service program handles environment protecting, EPC protecting so that CPU surpports multi-level interruption.
### Overview
   ![pipeline](https://cloud.githubusercontent.com/assets/10323518/24080240/d1bd5c8a-0cd5-11e7-81e6-50b0c80e13c7.png)
   
## Benchmarks
There are various programs for testing the CPU in the `Benchmarks` folder, with a combined final benchmark named `Benchmark.hex`.

All the benchmarks are assembled by `Mars`, a powerful MIPS assembling and debugging tool.

## General Components
### ALU Circuit
#### Description
This ALU is implememted to do 13 operations determined by operator S, with two input X/Y, it can produce result according to the operator S and emit signed and unsigned overflow/Equal signals.
The detailed circuit diagram is as below:
#### Overview

<img src="https://cloud.githubusercontent.com/assets/10323518/24080236/d172a820-0cd5-11e7-812c-e60f21efe0e0.png" alt="alu_1" width="70%">

#### Adder Circuit with Overflow Detection
  ![alu_2](https://cloud.githubusercontent.com/assets/10323518/24080237/d19ac71a-0cd5-11e7-8197-2de472d63d7c.png)
  
### Register File
#### Description
This regfile is implemented to simulate the 32 registers running in the MIPS CPU, with the signals passed to it, it can store data into register according to the given register number, and it can directly load up to two register's data to the port.
#### Overview
  ![regfile](https://cloud.githubusercontent.com/assets/10323518/24080241/d1bdb4be-0cd5-11e7-9aa7-e64e94d401a0.png)

## References
[1] Harris, David, and Sarah Harris. Digital design and computer architecture. Morgan Kaufmann, 2010.

[2] [MIPS Quick Reference](https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00565-2B-MIPS32-QRC-01.01.pdf)

[3] [MIPS® Architecture for Programmers Volume II-A: The MIPS32® Instruction Set Manual](https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00086-2B-MIPS32BIS-AFP-6.06.pdf)

## License
[MIT](https://github.com/yxwangcs/MIPS-CPU/blob/master/LICENSE).
