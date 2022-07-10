# ==== Start of Jump Instruction Tests ====
# The last jump label long_jmp is placed at the end of this benchmark program. This is made
# intentional so that we can test the ability for long jumps.
.text
    addi    $s1,        $zero,          1
    j       jmp_next1
    addi    $s1,        $zero,          1
    addi    $s2,        $zero,          2
    addi    $s3,        $zero,          3
jmp_next1:
    j       jmp_next2
    addi    $s1,        $zero,          1
    addi    $s2,        $zero,          2
    addi    $s3,        $zero,          3
jmp_next2:
    j       jmp_next3
    addi    $s1,        $zero,          1
    addi    $s2,        $zero,          2
    addi    $s3,        $zero,          3
jmp_next3:
    j       jmp_next4
    addi    $s1,        $zero,          1
    addi    $s2,        $zero,          2
    addi    $s3,        $zero,          3
jmp_next4:
    jal     long_jmp

# ==== End of (Partial) Jump Instruction Tests ====


# ==== Start of Shift Tests ====
# Simple shift, loop test, the 0th area will display initial value 1 and shift left 15 times,
# area 1 will display the sum.
.text
    addi    $s0,        $zero,          1
    addi    $s1,        $zero,          1
    sll     $s1,        $s1,            31              # logical shift left 31bits $s1=0x80000000


# Logical right shift test, the upper bit 1 will move to the right
# LED will display the following:
# 0x80000000, 0x20000000, 0x08000000, 0x02000000, 0x00800000, 0x00200000, 0x00080000, 0x00020000
# 0x00008000, 0x00002000, 0x00000800, 0x00000200, 0x00000080, 0x00000020, 0x00000008, 0x00000002
# 0x00000000
logical_rs:
    add     $a0,        $zero,          $s1             # display $s1
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall                                             # we are out of here.

    srl     $s1,        $s1,            2
    beq     $s1,        $zero,          shift_next1
    j       logical_rs

shift_next1:
    add     $a0,        $zero,          $s1             # display $s1
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall                                             # we are out of here.

# Logical left shift test
# LED will display the following:
# 0x00000004, 0x00000010, 0x00000040, 0x00000100, 0x00000400, 0x00001000, 0x00004000, 0x00010000
# 0x00040000, 0x00100000, 0x00400000, 0x01000000, 0x04000000, 0x10000000, 0x40000000, 0x00000000
    addi    $s1,        $zero,          1               # initialize s1 = 1
logical_ls:                                             # logical left shift
    sll     $s1,        $s1,            2

    add     $a0,        $zero,          $s1             # display $s1
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    beq     $s1,        $zero,          arith_rs
    j       logical_ls


# Aritmetic right test
# LED will display the following:
# 0x80000000 0xf0000000 0xff000000 0xfff00000 0xffff0000 0xfffff000 0xffffff00 0xfffffff0
# 0xffffffff
arith_rs:
    addi    $s1,        $zero,          1
    sll     $s1,        $s1,            31              # logical shift left 31bits $s1=0x80000000

    add     $a0,        $zero,          $s1             # display $s1
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    sra     $s1,        $s1,            3               # $s1=0X80000000-->0XF0000000

    add     $a0,        $zero,          $s1             # display $s1
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    sra     $s1,        $s1,            4               # 0XF0000000-->0XFF000000

    add     $a0,        $zero,          $s1             # display $s1
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    sra     $s1,        $s1,            4               # 0XFF000000-->0XFFF00000

    add     $a0,        $zero,          $s1             # display $s1
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    sra     $s1,        $s1,            4

    add     $a0,        $zero,          $s1             # display $s1
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    sra     $s1,        $s1,            4

    add     $a0,        $zero,          $s1             # display $s1
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    sra     $s1,        $s1,            4

    add     $a0,        $zero,          $s1             # display $s1
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    sra     $s1,        $s1,            4

    add     $a0,        $zero,          $s1             # display $s1
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    sra     $s1,        $s1,            4

    add     $a0,        $zero,          $s1             # display $s1
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall                                             # we are out of here.

# ==== End of Shift Tests ====

# ==== Start of Marquee-LED Banner Test ====
# This part simlulates a draw marquee-led banner.
# Test for addi, andi, sll, srl, sra, or, ori, nor, syscall.
.text
    addi    $s0,        $zero,          1
    sll     $s3,        $s0,            31              # $s3=0x80000000
    sra     $s3,        $s3,            31              # $s3=0xFFFFFFFF
    addu    $s0,        $zero,          $zero           # $s0=0
    addi    $s2,        $zero,          12

    addiu   $s6,        $0,             3               # count for displaying
marquee_loop:
    addiu   $s0,        $s0,            1               # calculate next light number
    andi    $s0,        $s0,            15

    addi    $t0,        $0,             8
    addi    $t1,        $0,             1

marquee_left:
    sll     $s3,        $s3,            4               # shift left
    or      $s3,        $s3,            $s0

    add     $a0,        $0,             $s3             # display $s3
    addi    $v0,        $0,             34              # system call for LED display
    syscall                                             # display

    sub     $t0,        $t0,            $t1
    bne     $t0,        $0,             marquee_left

    addi    $s0,        $s0,            1               # calculate the next light number
    addi    $t8,        $0,             15
    and     $s0,        $s0,            $t8
    sll     $s0,        $s0,            28

    addi    $t0,        $0,             8
    addi    $t1,        $0,             1

marquee_right:
    srl     $s3,        $s3,            4               # shift right
    or      $s3,        $s3,            $s0

    addu    $a0,        $0,             $s3             # display $s3
    addi    $v0,        $0,             34              # system call for LED display
    syscall                                             # display

    sub     $t0,        $t0,            $t1
    bne     $t0,        $0,             marquee_right
    srl     $s0,        $s0,            28

    sub     $s6,        $s6,            $t1
    beq     $s6,        $0,             marquee_exit
    j       marquee_loop

marquee_exit:
    add     $t0,        $0,             $0
    nor     $t0,        $t0,            $t0             # test nor  ori
    sll     $t0,        $t0,            16
    ori     $t0,        $t0,            0xffff

    addu    $a0,        $0,             $t0             # display $t0
    addi    $v0,        $0,             34              # system call for LED display
    syscall                                             # display

# ==== End of Marquee-LED Banner Test ====


# ==== Start of Data Hazard Tests ====
# This test calculates the sums of (1 to k) and stores the individual sum at 4*k memory
# address, which includes several read-after-write (RAW) data hazards to test the ability for
# hazard solutions.
# $s0 stores the current sum, $s1 stores k, and $s2 stores the memory address to store the
# calculated sum. Each step we roughly do the following:
# $s1 += 1     for incrementing the current k
# $s0 += $s1   for adding k to the current sum
# $s2 += 4     for shifting the memory address to save
# save $s0 to $s2 address
.text
    addi    $s1,        $zero,          4
    sw      $s1,        0($s1)
    lw      $s2,        0($s1)
    addi    $s2,        $s2,            -4              # s2 address, load-use related instructions
    addi    $s0,        $zero,          0               # initialize the current sum

    addi    $s1,        $s0,            1               # calculate the next number, difference is 1 data
                                                        # hazard with the previous instruction
    add     $s0,        $s0,            $s1             # sum up, data hazard with the previous instruction
    add     $s2,        $s2,            4               # shift the address
    sw      $s0,        0($s2)                          # store the sum

    addi    $s1,        $s1,            1
    add     $s0,        $s0,            $s1             # calculate the sum
    add     $s2,        $s2,            4               # shift the address
    sw      $s0,        0($s2)                          # store the sum

    addi    $s1,        $s1,            1
    add     $s0,        $s0,            $s1             # calculate the sum
    add     $s2,        $s2,            4               # shift the address
    sw      $s0,        0($s2)                          # store the sum

    addi    $s1,        $s1,            1
    add     $s0,        $s0,            $s1             # calculate the sum
    add     $s2,        $s2,            4               # shift the address
    sw      $s0,        0($s2)                          # store the sum

    addi    $s1,        $s1,            1
    add     $s0,        $s0,            $s1             # calculate the sum
    add     $s2,        $s2,            4               # shift the address
    sw      $s0,        0($s2)                          # store the sum

    addi    $s1,        $s1,            1
    add     $s0,        $s0,            $s1             # calculate the sum
    add     $s2,        $s2,            4               # shift the address
    sw      $s0,        0($s2)                          # store the sum

    addi    $s1,        $s1,            1
    add     $s0,        $s0,            $s1             # calculate the sum
    add     $s2,        $s2,            4               # shift the address
    sw      $s0,        0($s2)                          # store the sum

# Now we verify the numbers stored in 0x4-0x1c: 0x1, 0x3, 0x6, 0xa, 0xf, 0x15, 0x1c and clean up
# the memory along the way.
    addi    $t1,        $zero,          0x1
    lw      $t0,        0x4($zero)
    bne     $t0,        $t1,            error
    sw      $zero,      0x4($zero)

    addi    $t1,        $zero,          0x3
    lw      $t0,        0x8($zero)
    bne     $t0,        $t1,            error
    sw      $zero,      0x8($zero)

    addi    $t1,        $zero,          0x6
    lw      $t0,        0xc($zero)
    bne     $t0,        $t1,            error
    sw      $zero,      0xc($zero)

    addi    $t1,        $zero,          0xa
    lw      $t0,        0x10($zero)
    bne     $t0,        $t1,            error
    sw      $zero,      0x10($zero)

    addi    $t1,        $zero,          0xf
    lw      $t0,        0x14($zero)
    bne     $t0,        $t1,            error
    sw      $zero,      0x14($zero)

    addi    $t1,        $zero,          0x15
    lw      $t0,        0x18($zero)
    bne     $t0,        $t1,            error
    sw      $zero,      0x18($zero)

    addi    $t1,        $zero,          0x1c
    lw      $t0,        0x1c($zero)
    bne     $t0,        $t1,            error
    sw      $zero,      0x1c($zero)

# ==== End of Data Hazard Tests ====


# ==== Start of Sorting Test ====
# Bubble sort the memory 1-15 in descending order.
.text
sort_init:
    addi    $s0,        $zero,          -1
    addi    $s1,        $zero,          0

    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4
    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4
    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4
    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4
    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4
    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4
    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4
    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4
    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4
    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4
    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4
    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4
    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4
    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4
    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4
    sw      $s0,        0($s1)
    addi    $s0,        $s0,            1
    addi    $s1,        $s1,            4

    addi    $s0,        $s0,            1

    add     $s0,        $zero,          $zero
    addi    $s1,        $zero,          60              # the bounds for ordering
sort_loop:
    lw      $s3,        0($s0)
    lw      $s4,        0($s1)
    slt     $t0,        $s3,            $s4
    beq     $t0,        $zero,          sort_next       # order by descending order
    sw      $s3,        0($s1)
    sw      $s4,        0($s0)
sort_next:
    addi    $s1,        $s1,            -4
    bne     $s0,        $s1,            sort_loop

    add     $a0,        $zero,          $s0             # display $s0
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall                                             # DISP: disp $r0, 0

    addi    $s0,        $s0,            4
    addi    $s1,        $zero,          60
    bne     $s0,        $s1,            sort_loop

# ==== End of Sorting Tests ====


# ==== Start of B Instruction Tests ====
# This program will execute 16 instructions, including 5 R-Instruction, 11 I-Instruction.
# This is intended to check if beq and bne function properly.
.text
    addi    $s0,        $zero,          1
    addi    $s2,        $zero,          255
    addi    $s1,        $zero,          1
    addi    $s3,        $zero,          3
    beq     $s0,        $s2,            b_next1
    beq     $s0,        $s0,            b_next1
    addi    $s1,        $zero,          1               # the following instructions will not be executed
    addi    $s2,        $zero,          2
    addi    $s3,        $zero,          3
    j       error

b_next1:
    add     $a0,        $zero,          $s0             # display $s0
    addi    $v0,        $zero,          1               # print integer in $a0
    syscall                                             # DISP: disp $r0, 0 | $s0 might cause a data hazard

    bne     $s1,        $s1,            b_next2
    bne     $s1,        $s2,            b_next2

    addi    $s1,        $zero,          1               # the following instructions will not be executed
    addi    $s2,        $zero,          2
    addi    $s3,        $zero,          3
    j       error

b_next2:
    add     $a0,        $zero,          $s3             # display $s0
    addi    $v0,        $zero,          1               # print integer in $a0
    syscall                                             # DISP: disp $r0, 0  $s0 might cause a data hazard

# ==== End of B Instruction Tests ====


# ==== Start of ADDIU and ORI Tests ====
# Test ADDIU and ORI that they do zero extend and sign extend on immediate value

# Prepare $s1 to be 0xFFFF0000
# It will be used for clearing first 16 bits of $a0 using AND instruction
    add     $s1,        $zero,          -1
    sll     $s1,        $s1,            16

# Test that ADDIU does sign extend on immediate value
    add     $a0,        $zero,          $zero
    addiu   $a0,        $a0,            100
    addiu   $a0,        $a0,            -100
    bne     $a0,        $zero,          error           # $a0 must be 0x0

    add     $a0,        $zero,          $zero
    addiu   $a0,        $a0,            -100
    addiu   $a0,        $a0,            100
    bne     $a0,        $zero,          error           # $a0 must be 0x0

# Test that ORI does zero extend on immediate value
    add     $a0,        $zero,          $zero
    ori     $a0,        $a0,            0x7fff
    and     $a0,        $a0,            $s1
    bne     $a0,        $zero,          error           # $a0 must be 0x0

    add     $a0,        $zero,          $zero
    ori     $a0,        $a0,            0x8000
    and     $a0,        $a0,            $s1
    bne     $a0,        $zero,          error           # $a0 must be 0x0
    addiu   $a0,        $zero,          0

# ==== End of ADDIU and ORI Tests ====

# Now we have reached the end of the benchmark, meaning everything runs successfully.
    j       success


# The following parts of program will _never_ be normally executed, i.e., they are utility
# procedures that can only be directly jumped to.

# Guard the utility procedure section so that we can never reach here sequentially.
    j       error

# Do a syscall to halt the system.
halt:
    addi    $v0,        $zero,          10              # System call for halt
    syscall 

# Print 1CEDCAFE (IcedCafe) magic number to indicate success.
success:
    addi    $a0,        $zero,          0x1CED
    sll     $a0,        $a0,            16
    ori     $a0,        $a0,            0xCAFE
    addi    $v0,        $zero,          34
    syscall 
    j       halt

# Print BAADC0DE (BaadCode) magic number to indicate error.
error:
    addi    $a0,        $zero,          0xBAAD
    sll     $a0,        $a0,            16
    ori     $a0,        $a0,            0xC0DE
    addi    $v0,        $zero,          34
    syscall 
    j       halt

# ==== Start of (Partial) Jump Tests ====
# This is part of the jump test at the beginning of this benchmark program, which is intentionally
# put here to test the ability for long jumps.
# This piece of code can only be reached by j long_jmp (i.e., cannot be reached by sequentially
# running the program), so at the beginning we directly jump to the end.
long_jmp:
    addi    $s0,        $zero,          0
    addi    $s0,        $s0,            1
    add     $a0,        $zero,          $s0
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    addi    $s0,        $s0,            2
    add     $a0,        $zero,          $s0
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    addi    $s0,        $s0,            3
    add     $a0,        $zero,          $s0
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    addi    $s0,        $s0,            4
    add     $a0,        $zero,          $s0
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    addi    $s0,        $s0,            5
    add     $a0,        $zero,          $s0
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    addi    $s0,        $s0,            6
    add     $a0,        $zero,          $s0
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    addi    $s0,        $s0,            7
    add     $a0,        $zero,          $s0
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 

    addi    $s0,        $s0,            8
    add     $a0,        $zero,          $s0
    addi    $v0,        $zero,          34              # print integer in $a0 in hex
    syscall 
    jr      $31

# ==== End of (Partial) Jump Tests ====