_Z1fv:
        addiu   $sp,$sp,-24
        sw      $31,20($sp)
        sw      $fp,16($sp)
        move    $fp,$sp
        jal     _Z1gv
        nop

        move    $sp,$fp
        lw      $31,20($sp)
        lw      $fp,16($sp)
        addiu   $sp,$sp,24
        jr      $31
        nop