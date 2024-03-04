################################################################
# TREAT THIS FILE AS A BLACK BOX!!
# The implementation of these functions will change for grading
################################################################

.text
#################### digit2int ####################
	# Converts digit char to an int.
	# $a0: char c
digit2int:
    li $v0 -1
    blt $a0, 48, digit2int_done
    bgt $a0, 57, digit2int_done
    addi $v0, $a0, -48

    # Simulating different implementations
    li $t0, 0xBEEFCAFE
    move $t1, $t0
    move $t2, $t0
    move $t3, $t0
    move $t4, $t0
    move $t5, $t0
    move $t6, $t0
    move $t7, $t0
    move $t8, $t0
    move $t9, $t0
    move $a0, $t0
    move $a1, $t0
    move $a2, $t0
    move $a3, $t0

digit2int_done:
	jr $ra
