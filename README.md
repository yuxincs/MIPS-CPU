# MIPS-CPU

A Simulative CPU Running on MIPS Instruction System Based on Logisim.

![MIPS-CPU-GIF](https://user-images.githubusercontent.com/10323518/31847758-7194fee4-b5ef-11e7-8d66-48773d4e3897.gif)

## ALU Circuit
#### Description
This ALU is implememted to do 13 operations determined by operator S, with two input X/Y, it can produce result according to the operator S and emit signed and unsigned overflow/Equal signals.
The specific circuit diagram is as below:
#### Overview
  ![alu_1](https://cloud.githubusercontent.com/assets/10323518/24080236/d172a820-0cd5-11e7-812c-e60f21efe0e0.png)
#### Adder Circuit with Overflow Detection
  ![alu_2](https://cloud.githubusercontent.com/assets/10323518/24080237/d19ac71a-0cd5-11e7-8197-2de472d63d7c.png)
  
## Register File
#### Description
This regfile is implemented to simulate the 32 registers running in the MIPS CPU, with the signals passed to it, it can store data into register according to the given register number, and it can directly load up to two register's data to the port.
#### Overview
  ![regfile](https://cloud.githubusercontent.com/assets/10323518/24080241/d1bdb4be-0cd5-11e7-9aa7-e64e94d401a0.png)
  
## Single Cycle CPU
#### Description
Organized according to the circuit given by `Mars`' `MIPS X-Ray` function for better understanding.
#### Overview
  ![singlecyclecpu](https://cloud.githubusercontent.com/assets/10323518/24080239/d1bd5ae6-0cd5-11e7-927d-a2b877a9b139.png)
  
## Pipeline CPU with Bubble Insertion Method
Used `Bubble Insertion` method to prevent data and control hazard.
### Overview
  ![pipeline_bubble](https://cloud.githubusercontent.com/assets/10323518/24080238/d1bc1910-0cd5-11e7-8c7c-f3de3d97a30b.png)

## Pipeline CPU with Data Redirection Method
Used `Data Redirection` method to prevent data hazard, optimized so that it runs less cycles compared to `Bubble Insertion` method.

This pipeline CPU is equipped with a `CP0` which handles exception(interruption), with 3 intteruption source buttons named `ExpSrc0` `ExpSrc1` `ExpSrc2`

The CPU runs into exception mode on clicking one of the buttons, running an exception service program
which displays `2` or `4` or `8` determined by the source number of the clicked button.

The exception service program handles environment protecting, EPC protecting so that CPU surpports multi-level interruption.
### Overview
   ![pipeline](https://cloud.githubusercontent.com/assets/10323518/24080240/d1bd5c8a-0cd5-11e7-81e6-50b0c80e13c7.png)
   
## Benchmarks
There are various programs for testing the CPU in the `Benchmarks` folder, with a combined final benchmark named `Benchmark.hex`.

All the benchmarks are assembled by `Mars`, a powerful MIPS assembling and debugging tool.

## License
[MIT](https://github.com/yxwangcs/MIPS-CPU/blob/master/LICENSE).
