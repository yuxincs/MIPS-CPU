# block interruptions
    addi    $k0,    $zero,  1
    mtc0    $k0,    $1

    addi    $gp,    $zero,  0x400           # base pointer
    add     $fp,    $gp,    $sp

# store EPC value
    mfc0    $k0,    $0
    sw      $k0,    ($fp)
    addi    $fp,    $fp,    4
    addi    $sp,    $sp,    4

# retrive block number
    mfc0    $k1,    $2                      # retrive cause number
    mfc0    $k0,    $3                      # set block number
    mtc0    $k0,    $2

# saving environments to the stack
    sw      $s0,    ($fp)
    addi    $sp,    $sp,    4
    addi    $fp,    $fp,    4
    sw      $s4,    ($fp)
    addi    $sp,    $sp,    4
    addi    $fp,    $fp,    4
    sw      $s5,    ($fp)
    addi    $sp,    $sp,    4
    addi    $fp,    $fp,    4
    sw      $s6,    ($fp)
    addi    $sp,    $sp,    4
    addi    $fp,    $fp,    4
    sw      $a0,    ($fp)
    addi    $sp,    $sp,    4
    addi    $fp,    $fp,    4
    sw      $v0,    ($fp)
    addi    $sp,    $sp,    4
    addi    $fp,    $fp,    4
    sw      $k1,    ($fp)
    addi    $sp,    $sp,    4
    addi    $fp,    $fp,    4


# calc display number
    add     $s6,    $zero,  $k0
    addi    $s6,    $s6,    1

# unblock interruptions
    addi    $k0,    $zero,  0
    mtc0    $k0,    $1

# start of test program
    addi    $s4,    $zero,  5
    addi    $s5,    $zero,  1
loop:
    add     $s0,    $zero,  $s6
int_left_shift:
    add     $a0,    $0,     $s0             # display $s0
    addi    $v0,    $0,     34              # display hex
    syscall                                 # we are out of here.
    sll     $s0,    $s0,    4
    bne     $s0,    $zero,  int_left_shift
    sub     $s4,    $s4,    $s5
    bne     $s4,    $zero,  loop

# block interruptions
    addi    $k0,    $zero,  1
    mtc0    $k0,    $1

# restore environment
    addi    $fp,    $fp,    -4
    addi    $sp,    $sp,    -4
    lw      $k1,    ($fp)
    addi    $fp,    $fp,    -4
    addi    $sp,    $sp,    -4
    lw      $v0,    ($fp)
    addi    $fp,    $fp,    -4
    addi    $sp,    $sp,    -4
    lw      $a0,    ($fp)
    addi    $fp,    $fp,    -4
    addi    $sp,    $sp,    -4
    lw      $s6,    ($fp)
    addi    $fp,    $fp,    -4
    addi    $sp,    $sp,    -4
    lw      $s5,    ($fp)
    addi    $fp,    $fp,    -4
    addi    $sp,    $sp,    -4
    lw      $s4,    ($fp)
    addi    $fp,    $fp,    -4
    addi    $sp,    $sp,    -4
    lw      $s0,    ($fp)

# reset block register
    mtc0    $k1,    $2

# restore EPC value
    addi    $fp,    $fp,    -4
    addi    $sp,    $sp,    -4
    lw      $k0,    ($fp)
    mtc0    $k0,    $0

# unblock interruptions
    addi    $k0,    $zero,  0
    mtc0    $k0,    $1

    eret    
