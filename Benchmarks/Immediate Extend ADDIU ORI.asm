# Test ADDIU and ORI that they do zero extend and sign extend on immediate value
#
# The 8 digit 7-seg display must always show 00000000 which means all tests
# are successful.

# Prepare $s1 to be 0xFFFF0000
# It will be used for clearing first 16 bits of $a0 using AND instruction
add $s1,$zero,-1
nop
sll $s1,$s1,16
# Prepare "display" syscall
addi $v0,$zero,34

# Test that ADDIU does sign extend on immediate value
add $a0,$zero,$zero
nop
addiu $a0,$a0,100
nop
addiu $a0,$a0,-100
syscall # Must show 00000000

add $a0,$zero,$zero
nop
addiu $a0,$a0,-100
nop
addiu $a0,$a0,100
syscall # Must show 00000000

# Test that ORI does zero extend on immediate value
add $a0,$zero,$zero
nop
ori $a0,$a0,0x7fff
nop
and $a0,$a0,$s1
syscall # Must show 00000000

add $a0,$zero,$zero
nop
ori $a0,$a0,0x8000
nop
and $a0,$a0,$s1
syscall # Must show 00000000
addiu $a0,$zero,0

# Halt
addi $v0,$zero,10        # system call for exit
syscall                  # done
