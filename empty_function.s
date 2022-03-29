.global main
main:
addiu   $sp,$sp,-8
sw      $fp,-4($sp)
addiu t1, 3, 3
lw      $2, $t1
move    $sp,$fp
lw      $fp,4($sp)
addiu   $sp,$sp,8
jr      $31
nop
