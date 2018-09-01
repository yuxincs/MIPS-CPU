# Data hazard tests, the program will calculate arithmetic sequences. 38 instructions in total.
.text

addi $s1, $0, 4
sw $s1, 0($s1)
lw $s2, 0($s1)
addi $s2,$s2,-4    # s2 address      #load-use related instructions
addi $s0,$0,0      # initialize the array[0]
addi $s1,$s0,1     # calculate the next number, difference is 1  data hazard with the previous instruction
add $s0,$s0,$s1    # sum up, data hazard with the previous instruction
add $s2,$s2,4      # sum up the address
sw $s0,0($s2)      # store the sum
addi $s1,$s1,1
add $s0,$s0,$s1    # calculate the sum
add $s2,$s2,4      # add the address
sw $s0,0($s2)      # store the sum
addi $s1,$s1,1
add $s0,$s0,$s1    # calculate the sum
add $s2,$s2,4      # add the address
sw $s0,0($s2)      # store the sum
addi $s1,$s1,1
add $s0,$s0,$s1    # calculate the sum
add $s2,$s2,4      # add the address
sw $s0,0($s2)      # store the sum
addi $s1,$s1,1
add $s0,$s0,$s1    # calculate the sum
add $s2,$s2,4      # add the address
sw $s0,0($s2)      # store the sum
addi $s1,$s1,1
add $s0,$s0,$s1    # calculate the sum
add $s2,$s2,4      # add the address
sw $s0,0($s2)      # store the sum
addi $s1,$s1,1
add $s0,$s0,$s1    # calculate the sum
add $s2,$s2,4      # add the address
sw $s0,0($s2)      # store the sum

addi $v0,$zero,10        # system call for exit
addi $s0,$zero, 0        # remove hazard
addi $s0,$zero, 0
addi $s0,$zero, 0
syscall                  # done
