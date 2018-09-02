# Tests for j, jal, jr instructions, totaling 15 cycles
.text
 addi $s1,$zero, 1
 j jmp_next1
 addi $s1,$zero, 1
 addi $s2,$zero, 2
 addi $s3,$zero, 3
jmp_next1:
 j jmp_next2
 addi $s1,$zero, 1
 addi $s2,$zero, 2
 addi $s3,$zero, 3
jmp_next2:
 j jmp_next3
 addi $s1,$zero, 1
 addi $s2,$zero, 2
 addi $s3,$zero, 3
jmp_next3:
 j jmp_next4
 addi $s1,$zero, 1
 addi $s2,$zero, 2
 addi $s3,$zero, 3
jmp_next4:jal jmp_count


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


jmp_count: addi $s0,$zero, 0
       addi $s0,$s0, 1
       add    $a0,$0,$s0
       addi   $v0,$0,34        # display hex
       syscall                 # done

       addi $s0,$s0, 2
       add    $a0,$0,$s0
       addi   $v0,$0,34         # display hex
       syscall                  # done

       addi $s0,$s0, 3
       add    $a0,$0,$s0
       addi   $v0,$0,34         # display hex
       syscall                  # done

       addi $s0,$s0, 4
       add    $a0,$0,$s0
       addi   $v0,$0,34         # display hex
       syscall                  # done

       addi $s0,$s0, 5
       add    $a0,$0,$s0
       addi   $v0,$0,34         # display hex
       syscall                  # done

       addi $s0,$s0, 6
       add    $a0,$0,$s0
       addi   $v0,$0,34         # display hex
       syscall                  # done

       addi $s0,$s0, 7
       add    $a0,$0,$s0
       addi   $v0,$0,34         # display hex
       syscall                  # done

       addi $s0,$s0, 8
       add    $a0,$0,$s0
       addi   $v0,$0,34         # display hex
       addi   $v0,$0,34         # display hex
       syscall                  # done


       jr $31
