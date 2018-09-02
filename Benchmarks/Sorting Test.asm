# Sort the memory 1-15 in descending order
# Please set Memory Configuration to Compact��data at address 0 in Mars Setting to compile
 .text
sort_init:
 addi $s0,$0,-1
 addi $s1,$0,0

 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
  sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
  sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
 sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
  sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
  sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
  sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
  sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4
    sw $s0,0($s1)
 addi $s0,$s0,1
 addi $s1,$s1,4

 addi $s0,$s0,1

 add $s0,$zero,$zero
 addi $s1,$zero,60      # the bounds for ordering
sort_loop:
 lw $s3,0($s0)
 lw $s4,0($s1)
 slt $t0,$s3,$s4
 beq $t0,$0,sort_next   # order by descending order
 sw $s3, 0($s1)
 sw $s4, 0($s0)
sort_next:
 addi $s1, $s1, -4
 bne $s0, $s1, sort_loop

 add    $a0,$0,$s0       # display $s0
 addi   $v0,$0,34        # display hex
 syscall                 # done  DISP: disp $r0, 0

 addi $s0,$s0,4
 addi $s1,$zero,60
 bne $s0, $s1, sort_loop

 addi   $v0,$zero,10      # system call for exit
 syscall                  # done
