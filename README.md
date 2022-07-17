# MIPS-CPU

A Simulative 32-bit CPU Running on MIPS Instruction System Based on [Logisim](http://www.cburch.com/logisim/) (Newer version [Logisim Evolution](https://github.com/reds-heig/logisim-evolution) is not supported). Basic understanding of digital design and MIPS pipelined CPU is strongly recommended ([1] is a great textbook for learning). For more details about implementations please refer to the [wiki page](https://github.com/yuxincs/MIPS-CPU/wiki).

![MIPS-CPU-GIF](https://github.com/yuxincs/MIPS-CPU/raw/main/demo.gif)

Two categories of CPU, totaling three implementations, exist in this repository:

* **Single Cycle CPU:** Each instruction takes exactly one CPU cycle to finish. 
([single_cycle_cpu.circ](https://github.com/yuxincs/MIPS-CPU/blob/main/src/single_cycle_cpu.circ))

* **Pipelined CPU:** A five-stage pipelined CPU. There are two versions for solving the 
[hazards](https://en.wikipedia.org/wiki/Hazard_(computer_architecture)) introduced by pipelining: 

  1. [Pipeline Bubbling](https://en.wikipedia.org/wiki/Hazard_(computer_architecture)#PIPELINE-FLUSH) 
  for all hazards. ([pipeline_cpu_bubbling.circ](https://github.com/yuxincs/MIPS-CPU/blob/main/src/pipeline_cpu_bubbling.circ))

  2. Based on Pipeline bubbling, [Operand Forwarding](https://en.wikipedia.org/wiki/Operand_forwarding) 
  is used for data hazards to reduce the total number of pipeline stalls for better performance. 
  ([pipeline_cpu.circ](https://github.com/yuxincs/MIPS-CPU/blob/main/src/pipeline_cpu.circ)).

Note that the common components in `src/common` are shared among the CPUs, and must be present in 
the same folder as the CPU circ file for it to work.

The main and most feature-rich version is the pipelined CPU with operand forwarding, which will be 
referred to as MIPS-CPU in the rest of this README.

## Features

* Five-Stage Pipeline.

* [Hazard](https://en.wikipedia.org/wiki/Hazard_(computer_architecture)) Handling with Operand Forwarding.

* 7-Seg Display.

* 10-bit Address Space for ROM (Code) and RAM (Memory).

* Exception Handling: MIPS-CPU (and single cycle CPU) is equipped with a co-processor `CP0` which 
(only) handles exception (interruption), with 3 interruption source buttons named `ExpSrc[0-2]`. 
The CPU runs into exception mode on clicking one of the buttons, running an exception service 
program which displays 2 or 4 or 8 determined by the source number of the clicked button.

* Supported Instruction Set:

**Instruction**        | **Format**                | **Instruction**           | **Format**              
:--------------------: | :-----------------------: | :-----------------------: | :----------------------:
Add                    | add $rd, $rs, $rt         | Store Word                | sw $rt, offset($rs)     
Add Immediate          | addi $rt, $rs, immediate  | Branch on Equal           | beq $rs, $rt, label     
Add Immediate Unsigned | addiu $rt, $rs, immediate | Branch on Not Equal       | bne $rs, $rt, label     
Add Unsigned           | addu $rd, $rs, $rt        | Set Less Than             | slt $rd, $rs, $rt       
And                    | and $rd, $rs, $rt         | Set Less Than Immediate   | slti $rt, $rs, immediate
And Immediate          | andi $rt, $rs, immediate  | Set Less Than Unsigned    | sltu $rd, $rs, $rt      
Shift Left Logical     | sll $rd, $rt, shamt       | Jump                      | j label                 
Shift Right Arithmetic | sra $rd, $rt, shamt       | Jump and Link             | jal label               
Shift Right Logical    | srl $rd, $rt, shamt       | Jump Register             | jr $rs                  
Sub                    | sub $rd, $rs, $rt         | Syscall (Display or Exit) | syscall                 
Or                     | or $rd, $rs, $rt          | Move From Co-processor 0  | mfc0 $t0,$12            
Or Immediate           | ori $rt, $rs, immediate   | Move To Co-processor 0    | mtc0 $t0,$12            
Nor                    | nor $rd, $rs, $rt         | Exception Return          | eret                    
Load Word              | lw $rt, offset($rs) 

Refer to Quick Reference and Complete Instruction Manual from 
[MIPS](https://www.mips.com/products/architectures/mips32-2/) for complete specifications.
  
## Assembling and Loading Programs

There are many existing MIPS assemblers you can use, we used 
[`Mars`](http://courses.missouristate.edu/kenvollmar/mars/) since it is a powerful MIPS assembler
_and_ debugger. Bugs can be easily identified by running `Mars` to execute the programs 
instruction by instruction and compare registers, memories, etc. against our CPU implementation. 
The following steps can be used to obtain an assembled file to be loaded in `MIPS-CPU`:

  * `Settings` -> `Memory Configuration`, change configuration to `Compact, Data Address at 0`
  * Open the assembly code in `Mars`
  * `Run` -> `Assemble` to assembly the assembly code
  * `File` -> `Dump Memory` and choose `Hexadecimal Text` as Dump Format
  * Open the hex file and add a `v2.0 raw` line at the beginning
  * The hex file can then be loaded into the ROM part of MIPS-CPU for it to execute

### ROMs for Storing Assembled Programs
MIPS-CPU uses 10-bit address space for ROMs. Some special programs, e.g., exception service 
programs, require a pre-determined fixed  address and PC will be set to this address to call 
service programs when exceptions happen. Therefore, 10-bit address space ROM is implemented via 
two ROMs with 9-bit address widths, where the most significant bit of the address will be used 
to switch between the two ROMs. The second ROM (with a start address `0x00000800`) then serves
the purpose for loading / storing special service programs and cannot be mixed with normal 
programs. This design makes it really easy to load normal and special service programs in MIPS-CPU.

### Example Programs
For normal programs, a benchmark file containing various tests is located at 
`programs/benchmark.asm` along with assembled hex file ending with `.hex`. This benchmark file is 
preloaded in ROM in all versions of MIPS-CPU. When executed, the 7-seg LED screen will show various 
patterns and numbers (as showcased in the gif) and at the end show a magic number `0x1CEDCAFE` 
('iced cafe') to indicate success, if anything went wrong, `0xBAADC0DE` ('baad code') will be 
displayed instead.

For special service programs, an exception service program is provided at 
`programs/exception_service.asm` along with assembled  hex file. It handles saving environments 
(including saving PC value to EPC), executing an example service program, and then restore the 
environments at the end. It supports multi-level interruption by saving everything to a stack in 
RAM for each level of interruption. This program has to be loaded into the second ROM in MIPS-CPU, 
which is the special address reserved for the service program. Upon exception, PC will be set to 
`0x00000800` to run the service program. It is preloaded in the second ROM in all versions of 
MIPS-CPU that support exception handling.

## References
[1] Harris, David, and Sarah Harris. Digital design and computer architecture. Morgan Kaufmann, 2010.

[2] [MIPS Quick Reference](https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00565-2B-MIPS32-QRC-01.01.pdf)

[3] [MIPS® Architecture for Programmers Volume II-A: The MIPS32® Instruction Set Manual](https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00086-2B-MIPS32BIS-AFP-6.06.pdf)

## License
[MIT](https://github.com/yuxincs/MIPS-CPU/blob/master/LICENSE).
