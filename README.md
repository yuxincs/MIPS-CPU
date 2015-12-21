# MIPS-CPU
###### By : Ryan Wang @ HUST
###### Email : wangyuxin@hust.edu.cn
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

