# This program will execute 16 instructions, including 5 R-Instruction, 11 I-Instruction.
# Check if beq, bne instructions function properly.
.text
addi $s0,$zero,1
addi $s2,$zero,255
addi $s1,$zero,1
addi $s3,$zero,3
beq $s0, $s2, Next1
beq $s0, $s0, Next1
addi $s1,$zero,1         # this will not be executed
addi $s2,$zero,2
addi $s3,$zero,3

Next1:
 add    $a0,$0,$s0       # display $s0
 addi   $v0,$0,1         # system call for exit
 syscall                 # we are out of here.  DISP: disp $r0, 0 | $s0 might cause a data hazard

 bne $s1, $s1, Next2
 bne $s1, $s2, Next2

 addi $s1,$zero,1        # this will not be executed
 addi $s2,$zero,2
 addi $s3,$zero,3

Next2:
 add    $a0,$0,$s3       # display $s0
 addi   $v0,$0,1         # system call for exit
 syscall                 # we are out of here.  DISP: disp $r0, 0  $s0 might cause a data hazard

 addi   $v0,$zero,10     # system call for exit
 syscall                 # we are out of here.
