.include "hw4_antonile.asm"
.include "hw4_helpers.asm"
.data
        # Define data section for moves array, move string, and playerShips
    moves: .half 0x0199      # Initial move in moves array
    .space 398               # Remaining space for 99 more moves (2 bytes each)
    moveString: .asciiz "J9\n"
playerShips: 
    # Player 0 Ships
    .byte 0, 0, 82, 4, 0, 0  # Ship 0: Right, Length 4
    .byte 2, 2, 68, 3, 0, 0  # Ship 1: Down, Length 3
    .byte 4, 5, 82, 2, 0, 0  # Ship 2: Right, Length 2
    .byte 6, 7, 68, 5, 0, 0  # Ship 3: Down, Length 5
    .byte 8, 3, 82, 3, 0, 0  # Ship 4: Right, Length 3

    # Player 1 Ships
    .byte 1, 1, 68, 4, 0, 0  # Ship 0: Down, Length 4
    .byte 3, 4, 82, 2, 0, 0  # Ship 1: Right, Length 2
    .byte 5, 6, 68, 3, 0, 0  # Ship 2: Down, Length 3
    .byte 7, 8, 82, 5, 0, 0  # Ship 3: Right, Length 5
    .byte 9, 8, 82, 2, 0, 0  # Ship 4: Right, Length 2
    
filename: .asciiz "P0_ships.txt"
.text
.globl main
main:
    # Initialize registers and arguments for loadBoards
    la $a0, playerShips           
    li $a1, 0    
    la $a2, filename           
    li $a3, 0x6             
    li $t0, 0x9             
    li $t1, 0xB             
    
    
    addi $sp, $sp, -8     
    sw $t0, 4($sp)          
    sw $t1, 0($sp)          
    jal readFile