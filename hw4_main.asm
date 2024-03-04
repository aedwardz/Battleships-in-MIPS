.include "hw4_antonile.asm"
.include "hw4_helpers.asm"

.globl main
.text
main:
	j lbTest
setcelltest:
	la $a0, board
	lw $a0, 0($a0)
	
	la $a1, row
	lw $a1, 0($a1)
	
	la $a2, col
	lw $a2, 0($a2)
	
	la $a3, val
	lw $a3, 0($a3)
	
	li $t0, 0x29
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	
	jal setCell
	
	addi $sp, $sp, 4
	
	move $a1, $v0
	la $a0, setcell_outp
	li $v0, 4
	syscall
	
	move $a0, $a1
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
fillBoardTest:
	la $a0, board1
	lw $a0, 0($a0)
	
	la $a1, color
	lb $a1, 0($a1)
	
	la $a2, c
	lb $a2, 0($a2)
	
	jal fillBoard
	
hideBoardTest:
	la $a0, cellColor
	lb $a0, 0($a0)
	
	la $a1, playerColor
	lb $a1, 0($a1)
	
	la $a2, player
	lw $a2, 0($a2)
	
	jal hideBoard
	li $v0, 10
	syscall

getColorTest:
	li $a0, 0
	li $a1, 0xAA
	li $a2, 0
	
	jal fillBoard
	
	li $a0, 0
	li $a1, 9
	li $a2, 9
	 
	jal getColor
	
	li $t1, 1

changeBgTest:
	li $a0, 0
	li $a1, 2
	li $a2, 4
	li $a3, 72
	addi $sp, $sp, -4
	li $t0, 0x29
	sw $t0, 0($sp)
	jal setCell
	
	li $a0, 0
	li $a1, 3
	li $a2, 7
	li $a3, 65
	li $t0, 0x35
	sw $t0, 0($sp)
	
	jal setCell
	
	li $a0, 0
	li $a1, 5
	li $a2, 3
	li $a3, 87
	li $t0, 0x60
	sw $t0, 0($sp)
	jal setCell
	
	addi $sp, $sp, 4
	
	li $a0, 0
	li $a1, 1
	li $a2, 4
	li $a3, 4
	
	jal changeBG
	
	li $v0, 10
	syscall
	
	
	
drawShipTest:
	li $a0, 0
	li $a1, 0xCF
	li $a2, 'W'
	
	jal fillBoard
	
	
	
	li $a0, 0
	la $a1, ship1
	
	jal drawShip
	
	li $v0, 10
	syscall
	
	
	
displayShipsTest:
	li $a0, 0
	li $a1, 0xCF
	li $a2, 'W'
	
	jal fillBoard
	
	
	li $a0, 0
	la $a1, playerships
	li $a2,0
	li $a3, 1
	
	 jal displayShips 
gsiTest:
	li $t0, 0xE
	la $a0, line
	la $a1, ship1
	li $a2, 0x2
	li $a3, 0x1
	addi $sp, $sp, -4
	li $t0, 0x7
	sw $t0, 0($sp)
	jal getShipInfo
	addi $sp, $sp, 42

readFileTest:

	la $a0, playerships
	li $a1, 0
	la $a2, fileName
	li $a3, 0x6
	addi $sp, $sp, -8
	li $t0, 0x9
	li $t1, 0xB
	sw $t0, 4($sp)
	sw $t1, 0($sp)
	jal readFile
	addi $sp, $sp, 8

isHitTest:
	la $a0, playerships
	li $a1, 0
	li $a2, 9
	li $a3, 9
	
	jal isHit
	
	li $t0, 1
	li $v0, 10
	syscall

pmTest:

	li $a0, 0
	li $a1, 0xCF
	li $a2, 'W'
	jal fillBoard
	
	li $a0, 0
	la $a1, playerships
	li $a2, 1
	li $a3, 0
	jal displayShips
	
	
	
	
	
	
	la $a0, moves
	li $a1, 2
	li $a2, 0
	la $a3, moveString
	la $t0, playerships
	
	addi $sp, $sp, -12
	sw $t0, 8($sp)
	li $t0, 0xE
	sw $t0, 4($sp)
	li $t0, 0xA
	sw $t0, 0($sp)
	jal playerMove
	addi $sp, $sp, 12


lbTest:
	li $a0, 1
	la $a1, playerships
	la $a2, moves
	li $a3, 0
	li $t0, 0x5
	addi $sp, $sp, -12
	sb $t0, 8($sp)
	li $t0, 0x3
	sb $t0, 4($sp)
	li $t0, 4
	sb $t0, 0($sp)
	jal loadBoards
	addi $sp, $sp, 12
	

	
	
	

	
	


	
	
	
	
.data
#setcelltesting
board: .word 0
row: .word 9
col: .word 9
val: .word 60
setcell_outp: .asciiz "setcell return: "

#fillBoard testing
board1: .word 1
color: .byte 0x2D
c: .byte 77

#hideBoard testing
cellColor: .byte 0xC0
playerColor: .byte 0xF0
player: .word 0


ship1: .byte 1, 4, 'R', 4, 0, 0x0D

playerships:	.byte 0, 0, 0, 0, 0, 0x0
		
		.byte 5, 2, 'R', 4, 4, 0x5	
		.byte 5, 7, 'D', 5, 0, 0xC
		.byte 7, 0, 'D', 3, 2, 0x3
		.byte 4, 6, 'D', 6, 2, 0x3
		
		.byte 1, 1, 68, 4, 0, 0x1  # Ship 0: Down, Length 4
    		.byte 3, 4, 82, 2, 0, 0x1  # Ship 1: Right, Length 2
    		.byte 5, 6, 68, 3, 2, 0x1  # Ship 2: Down, Length 3
    		.byte 5, 7, 'D', 5, 0, 0x1  # Ship 3: Right, Length 5
    		.byte 9, 8, 82, 2, 0, 0x1  # Ship 4: Right, Length 2
		
line: .asciiz "B0RE2"
fileName: .asciiz "P0_ships.txt"

moves: .half 0x0199      # Initial move in moves array
    .space 398               # Remaining space for 99 more moves (2 bytes each)
    moveString: .asciiz "C1\n"

