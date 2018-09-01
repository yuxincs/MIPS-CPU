# Shift test, this program needs support for addi,sll,add,syscall,srl,sll,sra,beq,j,syscall
.text
addi $s0,$zero,1    # simple shift, loop test, the 0th area will display initial value 1 and shift left 15 times,  area 1 will display the sum
addi $s1,$zero,1
sll $s1, $s1, 31   # logical shift left 31bits $s1=0x80000000


# Logical left test
# LED will display 0x80000000 0x20000000 0x08000000 0x02000000 0x00800000 0x00200000 0x00080000 0x00020000 0x00008000 0x00002000 0x00000800 0x00000200 0x00000080 0x00000020 0x00000008 0x00000002 0x00000000

LogicalRightShift:      # logical right test, the upper bit 1 will move to the right

add    $a0,$0,$s1       # display $s1
addi   $v0,$0,34        # display hex
syscall                 # we are out of here.

srl $s1, $s1, 2
beq $s1, $zero, shift_next1
j LogicalRightShift

shift_next1:

add    $a0,$0,$s1       # display $s1
addi   $v0,$0,34        # display hex
syscall                 # we are out of here.

# logical shift left test
# LED will display 0x00000004 0x00000010 0x00000040 0x00000100 0x00000400 0x00001000 0x00004000 0x00010000 0x00040000 0x00100000 0x00400000 0x01000000 0x04000000 0x10000000 0x40000000 0x00000000
addi $s1,$zero, 1
LogicalLeftShift:       # logical left shift
sll $s1, $s1, 2

add    $a0,$0,$s1       # display $s1
addi   $v0,$0,34        # display hex
syscall                 # done

beq $s1, $zero, ArithRightShift
j LogicalLeftShift


# aritmetic right test
# LED will display 0x80000000 0xf0000000 0xff000000 0xfff00000 0xffff0000 0xfffff000 0xffffff00 0xfffffff0 0xffffffff
ArithRightShift:

addi $s1,$zero,1
sll $s1, $s1, 31        # logical shift left 31bits $s1=0x80000000

add    $a0,$0,$s1       # display $s1
addi   $v0,$0,34        # display hex
syscall                 # done

sra $s1, $s1, 3    #$s1=0X80000000-->0XF0000000

add    $a0,$0,$s1       # display $s1
addi   $v0,$0,34        # display hex
syscall                 # done


sra $s1, $s1, 4         #0XF0000000-->0XFF000000

add    $a0,$0,$s1       # display $s1
addi   $v0,$0,34        # display hex
syscall                 # done


sra $s1, $s1, 4         #0XFF000000-->0XFFF00000

add    $a0,$0,$s1       # display $s1
addi   $v0,$0,34        # display hex
syscall                 # done

sra $s1, $s1, 4

add    $a0,$0,$s1       # display $s1
addi   $v0,$0,34        # display hex
syscall                 # done

sra $s1, $s1, 4

add    $a0,$0,$s1       # display $s1
addi   $v0,$0,34        # display hex
syscall                 # done


sra $s1, $s1, 4

add    $a0,$0,$s1       # display $s1
addi   $v0,$0,34        # display hex
syscall                 # done


sra $s1, $s1, 4

add    $a0,$0,$s1       # display $s1
addi   $v0,$0,34        # display hex
syscall                 # done


sra $s1, $s1, 4


add    $a0,$0,$s1       # display $s1
addi   $v0,$0,34        # display hex
syscall                 # we are out of here.

addi   $v0,$zero,10     # system call for exit
syscall                 # done
