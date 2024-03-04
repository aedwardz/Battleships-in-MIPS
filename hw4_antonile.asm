#Antonio Edwards
#antonile

.text


setCell:
	#error cases
	li $t0, 1
	li $t1, 9
	bgt $a0, $t0, error
	bltz $a0, error
	blt $a1, $0, error
	bgt $a1, $t1, error
	blt $a2, $0, error
	bgt $a2, $t1, error
	bgt $a1, $t1, error
	li $t0, 0x7F
	li $t1, 0xFF
	blt  $a3, $t0, noError
	bge $a3, $t1, noError
	error:
		li $v0, -1
		jr $ra
	
	#main function
noError:
	bgtz $a0, addTen
	j noAdd
		
		
	addTen:
	addi $t0, $a1, 10
	j calcAddr
	
	noAdd:
	move $t0, $a1
	
	
	#t0 = new row number
	
	calcAddr:
	li $t2, 10
	mul $t1, $t0, $t2
	
	add $t1, $t1, $a2
	
	sll $t1, $t1, 1
	
	addi $t1, $t1, 0xffff0000
	
	#t1 = address at cell
	lw $t3, 0($sp)
	beqz $a3, clear
	bltz $a3, colorOnly
	
	
	
	sb $t3, 1($t1)
	sb $a3, 0($t1)
	jr $ra
	
	
	#if val = 0
	clear:
		sb $t3, 1($t1)
		sb $0, 0($t1)
		li $v0, 0
		jr $ra
		
	colorOnly:
		sb $t3, 1($t1)
		li $v0, 0
		jr $ra


fillBoard:

    # Insert implementation here
    addi $sp, $sp, -28
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $ra, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    sw $s5, 24($sp)
    #nested for loop
    
    
	li $s0, 0
	li $s1, 0
	li $s2, 0xffff0000
	li $s3, 10
	 #starting address of the board
	
	bgtz $a0, bottomBoard
	j nestedLoop
	
	bottomBoard:
	li $t1, 10
	mul $t0, $t1, $t1
	sll $t0, $t0, 1
	add $s2, $s2, $t0
	
	nestedLoop:
	beq $s0, $s3, loopDone
	
	innerloop:
		beq $s1, $s3, nxt
		move $a3, $a2
		addi $sp, $sp, -4
		sw $a1, 0($sp)
		move $s5, $a1
		
		move $a1, $s0
		move $a2, $s1
		move $s4, $a3
		
		jal setCell
		move $a2, $s4
		move $a1, $s5
		
		addi $sp, $sp, 4
		addi $s1, $s1, 1
		j innerloop
	nxt:
		addi $s0, $s0, 1
		li $s1, 0
		j nestedLoop
	
	loopDone:

    		lw $s0, 0($sp)
    		lw $s1, 4($sp)
    		lw $ra, 8($sp)
    		lw $s2, 12($sp)
    		lw $s3, 16($sp)
    		lw $s4, 20($sp)
    		lw $s5, 24($sp)
    		addi $sp, $sp, 28
    		jr $ra
		
	
	   




hideBoard:

	# Insert implementation here
	#first fill the board with the color only
	#val must = 0
	#fillboard(board, color, 0)
	
	li $t0, 1
	bgt $a2, $t0, ERROR
	bltz $a2, ERROR
	j NO_ERROR
	
	
	ERROR:
		li $v0, -1
		jr $ra
	
	NO_ERROR:
	
	addi $sp, $sp, -28	
	
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	
	
	move $s0, $a0 
	move $s1, $a1
	move $s2, $a2
	
	#upperboard
	move $a1, $a0
	li $a2, 0	
	li $a0, 0
	jal fillBoard
	
	#lower board
	move $a1, $s0
	li $a0, 1
	li $a2, 0
	jal fillBoard
	
	
	li $s3, 1
	li $s4, 8
	li $s5, 3
	
	playerLoop:
		bgt $s3, $s4, playerLoopEnd
		
		li $a0, 0
		move $a1, $s5
		move $a2, $s3
		li $a3, 0
		
		addi $sp, $sp, -4
		
		sw $s1, 0($sp)
		jal setCell
		
		addi $sp, $sp, 4
		
		addi $s3, $s3, 1
		j playerLoop
	playerLoopEnd:
		
		#print player x
		li $a0, 0
		li $a1, 3
		li $a2, 1
		
		li $a3, 80

		addi $sp, $sp, -4
		sw $s1, 0($sp)
		
		jal setCell
		li $a3, 108
		addi $a2, $a2, 1
		
		jal setCell
		
		li $a3, 97
		addi $a2, $a2, 1
		
		jal setCell
		
		li $a3, 121
		addi $a2, $a2, 1
		jal setCell
		
		li $a3, 101
		addi $a2, $a2, 1
		jal setCell
		
		li $a3, 114
		addi $a2, $a2, 1
		jal setCell
		
		li $a3, 0
		addi $a2, $a2, 1
		jal setCell
		
		beqz $s2, asciiChange
		li $a3, 50
		j asciiChanged
		asciiChange:
		li $a3, 49
		
		asciiChanged:
		addi $a2, $a2, 1
		
		jal setCell
		
		li $a0, 1
		li $a1, 3
		li $a2, 3
		li $a3, 84
		
		jal setCell
		li $a3, 117
		addi $a2, $a2, 1
		jal setCell
		
		li $a3, 114
		addi $a2, $a2, 1
		
		jal setCell
		li $a3, 110
		addi $a2, $a2, 1
		jal setCell
		
		addi $sp, $sp, 4
		li $v0, 0

	
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		lw $s4, 20($sp)
		lw $s5, 24($sp) 
		addi $sp, $sp, 28
		jr $ra

getColor:
	li $t0, 1
	bgt $a0, $t0, error1
	bltz $a0, error1
	
	li $t1, 9
	bltz $a1, error1
	bgt $a1, $t1, error1
	
	bltz $a2, error1
	bgt $a2, $t1, error1
	j noError1
	
	error1:
		li $v0, -1
		jr $ra
	noError1:
		bgtz $a0, addTen1
		j tenAdded
		
		addTen1:
			addi $a1, $a1, 10
		tenAdded:

		li $t2, 10
		
		mul $t0, $a1, $t2
		add $t0, $t0, $a2
		sll $t0, $t0, 1
		addi $t0, $t0, 0xffff0000
		
		lbu $v0, 1($t0)
		jr $ra
		
		
			
		


changeBG:

    # Insert implementation here
	li $t0, 1
	bgt $a0, $t0, bgError
	bltz $a0, bgError
	
	li $t1, 9
	bltz $a1, bgError
	bgt $a1, $t1, bgError
	
	bltz $a2, bgError
	bgt $a2, $t1, bgError
	
	li $t0, 0x0
	li $t1, 0xF
	
	blt $a3, $t0, bgError
	bgt $a3, $t1, bgError
	
	j noBgError
    
     	bgError:
     		li $v0, -1
     		jr $ra
     	noBgError:
     		addi $sp, $sp, -20
     		sw $ra, 0($sp)
     		sw $s0, 4($sp)
     		sw $s1, 8($sp)
     		sw $s2, 12($sp)
     		sw $s3, 16($sp) 
     		
     		move $s0, $a0
     		move $s1, $a1
     		move $s2, $a2
     		move $s3, $a3
     		jal getColor
     		
     		li $t0, 0x0F
     		
     		move $a3, $s3
     		sll $a3, $a3, 4
     		and $v0, $v0, $t0
     		or $v0, $v0, $a3
     		
     		move $a0, $s0
     		move $a1, $s1
     		move $a2, $s2
     		li $a3, -1
     		addi $sp, $sp, -4
     		sw $v0, 0($sp)
     		jal setCell
     		addi $sp, $sp, 4
     		
     		li $v0, 0
     		

     		lw $ra, 0($sp)
     		lw $s0, 4($sp)
     		lw $s1, 8($sp)
     		lw $s2, 12($sp)
     		lw $s3, 16($sp)
     		
     		addi $sp, $sp, 20
     		
     		jr $ra
     		
     		
     		
     		
     		
     		
     		
     		
     		
     		
     	

################### PART 2 ##############################

wonGame:
	li $t0, 1
	bgt $a1, $t0, wonGameError
	bltz $a1, wonGameError
	j noWgError
	wonGameError:
		li $v0, -1
		jr $ra
	
	noWgError:
	
	#determine which player gets checked
	beqz $a1, checkp2
	
	checkp1:
		li $t0, 0
		j check
	checkp2:
		li $t0, 1
	check:
		#t0 = row
		
		li $t1, 0
		li $t2, 5
		li $t4, 6
		li $t9, 0
		shipLoop:
			beq $t1, $t2, shipLoopDone
			mul $t3, $t0, $t2
			add $t3, $t1, $t3
			mul $t3, $t3, $t4
			add $t3, $a0, $t3
			
			#t3 = ship address
			lb $t5, 3($t3)
			lb $t6, 4($t3)
			
			beq $t5, $t6, destroyed
			j increment
			
			destroyed:
				addi $t9, $t9, 1
			
			increment:
				addi $t1, $t1, 1
				j shipLoop
		shipLoopDone:
			beq $t9, $t2, broWon
			li $v0, -1
			jr $ra
		broWon:
			li $v0, 0
			jr $ra

drawShip:
	li $t0, 1
	bgt $a0, $t0, drawShipError
	bltz $a0, drawShipError
	
	lb $t0, 0($a1)
	lb $t1, 1($a1)
	
	li $t2, 9
	
	bgt $t0, $t2, drawShipError
	bgt $t1, $t2, drawShipError
	
	bltz $t0, drawShipError
	bltz $t1, drawShipError
	
	lb $t2, 2($a1)
	
	beq $t2, 'R', noDsError
	beq $t2, 'D', noDsError
	

	drawShipError:
		li $v0, -1
		jr $ra
	
	noDsError:
	addi $sp, $sp, -32
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s7, 28($sp)
	
	
	move $s0, $t0
	move $s1, $t1
	move $s2, $t2
	#s0 = start row
	#s1 = start_col
	#s2 = direction
	lb $t3, 3($a1)
	move $s3, $t3
	
	
	li $t9, 10
	bgtz $a0, pls10
	j tenadd
	
	
	pls10:
		addi $s0, $s0, 10
	tenadd:
	
	#s3 = len
	beq $t2, 'D', vertical
	
	horizontal:
		#calculate endpoint (start col + (len-1))
		addi $t4, $s3, -1
		add $t4, $t4, $t1
		move $s4, $t4
		#s4 = end column

		
		horizontalLoop:

			bgt $s1, $s4, horizontalDone
			
			#calculate ship address (row always the same)
			li $t0, 10
			mul $s5, $s0, $t0
			add $s5, $s5, $s1
			sll $s5, $s5, 1
			addi $s5, $s5, 0xffff0000
			
			#s5 = address of ship spot
			lb $t7, 5($a1) #t7 = bg color
			move $s7, $a1
			
			#s0 = start row
			#s1 = start_col
			#s2 = direction
			#s4 = end column
			
			move $a1, $s0
			move $a2, $s1
			move $a3, $t7
			jal changeBG
			
			#now check if there is a W
			move $a1, $s7
			
			lb $t0, 0($s5)
			
			beq $t0, 'W', nullify
				j nxxt
			nullify:
				sb $0, 0($s5)
			
			nxxt:
			addi $s1, $s1, 1
			j horizontalLoop			
		
		horizontalDone:
			li $v0, 0
			j epi
		
	
	vertical:
		#calculate end addr 
		# s0 = start row + length-1
		#s0 = start row
		#s1 = start_col
		#s2 = direction
		#s3 = len
		
		addi $s4, $s3, -1
		add $s4, $s0, $s4
	
		
		verticalLoop:
			bgt $s0, $s4, verticalLoopDone
			li $t0, 10
			mul $s5, $s0, $t0
			add $s5, $s5, $s1
			sll $s5, $s5, 1
			
			addi $s5, $s5, 0xffff0000
			
			lb $t7, 5($a1)
			
			move $s7, $a1
			
			#s0 = start row
			#s1 = start_col
			#s2 = direction
			#s4 = end column
			
			move $a1, $s0
			move $a2, $s1
			move $a3, $t7
			jal changeBG
			
			#now check if there is a W
			move $a1, $s7
			
			lb $t0, 0($s5)
			
			beq $t0, 'W', nullify2
				j nxxt2
			nullify2:
				sb $0, 0($s5)
			
			nxxt2:
			addi $s0, $s0, 1
			j verticalLoop 
	verticalLoopDone:
		li $v0, 0
		j epi		
			
		
	
	epi:
		
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		lw $s4, 20($sp)
		lw $s5, 24($sp)
		lw $s7, 28($sp)
		addi $sp, $sp, 32
		jr $ra
		
	
	
	

displayShips:

    # Insert implementation here
    bgt $a0, 1, dsError
    bltz $a0, dsError
    
    bgt $a2, 1, dsError
    bltz $a2, dsError
    
    bgt $a3, 1, dsError
    bltz $a3, dsError
    
    j noDsError1
    
    dsError:
    	li $v0, -1
    	jr $ra
    
	noDsError1:
		addi $sp, $sp, -36
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2, 12($sp)
		sw $s3, 16($sp)
		sw $s4, 20($sp)
		sw $s5, 24($sp)
		sw $s6, 28($sp)
		sw $s7, 32($sp)
		
		move $s5, $a1
		move $s6, $a3
		
		
		li $t0, 1
		seq $s0, $t0, $a2
		#s0 = row
		#s1 = column

		li $s1, 0
		li $s7, 0
		dsLoop:
			li $t0, 5
			beq $s1, $t0, dsLoopDone
			
			#calc playerships addr
			mul $s2, $s0, $t0
			add $s2, $s1, $s2 
			li $t1, 6
			mul $s2, $s2, $t1
			add $s2, $s2, $a1
			#s2 = addr of ship at given index
			lb $s3, 3($s2)
			lb $s4, 4($s2)
			
			#check what mode we are in
			beq $a3, 1, sunkShipsOnly
			j printShip
			sunkShipsOnly:
				bne $s3, $s4, skip
			printShip:
				move $a1, $s2
				jal drawShip
				addi $s7, $s7, 1
				move $a1, $s5
				move $a3, $s6
			skip:
				addi $s1, $s1, 1
				j dsLoop		
		dsLoopDone:
			move $v0, $s7
			
			lw $ra, 0($sp)
			lw $s0, 4($sp)
			lw $s1, 8($sp)
			lw $s2, 12($sp)
			lw $s3, 16($sp)
			lw $s4, 20($sp)
			lw $s5, 24($sp)
			lw $s6, 28($sp)
			lw $s7, 32($sp)
			addi $sp, $sp, 36
			
			jr $ra



getShipInfo:
	lw $t0, 0($sp) 
	addi $sp, $sp, -36
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)
	
        #------------------#
	move $s5, $t0
	lbu $s0, 0($a0) #row
	lbu $s1, 1($a0) #col
	lbu $s2, 2($a0) #direction
	lbu $s3, 3($a0) #bgcolor
	lbu $s4, 4($a0) #len
	#$s5 = defaultcolor
	move $s6, $a0 #line
	move $s7, $a1 #ship
	
	blt, $s0, 'A', infoError
	bgt, $s0, 'J', infoError
	
	blt, $s1, '0', infoError
	bgt $s1, '9', infoError
	
	
	
	j noInfoError
	infoError:
		li $v0, -1
		jr $ra
	
	
	noInfoError:
		addi $s0, $s0, -17
		move $a0, $s0
		jal digit2int
		

		
		move $s0, $v0
		#$s0 = int($s0)
		
		move $a0, $s1
		jal digit2int
		move $s1, $v0
		#s1 = int(s1)
		
		move $a0, $s4
		jal digit2int
		move $s4, $v0
		#s4 = int(s4)
		
		ble $s3, '9', numeric
		addi $s3, $s3, -55
		j fasho
		
		numeric: 
			addi $s3, $s3, -48
		
		fasho:
		
		
		beq, $s3, 0x8, infoError
		beq $s3, $a2, infoError
		beq $s3, $a3, infoError
		beq $s3, $s5, infoError
		
		#calculate where the end of the ships is for  boundaries
		addi $t0, $s4, -1
		beq $s2, 'D', down
		j right
		
		down:
			add $t0, $t0, $s0
			bgt $t0, 9, infoError
			j fillShip
		
		right:
			add $t0, $t0 , $s1
			bgt $t0, 9, infoError
		fillShip:
		#s7 = ships
			sb $s0, 0($s7)
			sb $s1, 1($s7)
			sb $s2, 2($s7)
			sb $s3, 5($s7)
			sb $0, 4($s7)
			sb $s4, 3($s7)
			
			 move $v0, $s4
			 
			 
			lw $ra, 0($sp)
			lw $s0, 4($sp)
			lw $s1, 8($sp)
			lw $s2, 12($sp)
			lw $s3, 16($sp)
			lw $s4, 20($sp)
			lw $s5, 24($sp)
			lw $s6, 28($sp)
			lw $s7, 32($sp)
			addi $sp, $sp, 36
			 jr $ra 
		
		
		
		
		
		
	

    # Insert implementation here


readFile:
	bltz $a1,invalplayer
	bgt $a1, 1, invalplayer
	j valplayer
	
	invalplayer:
		li $v0, -1
		jr $ra
	valplayer:
	lbu $t0, 4($sp)
	lbu $t1, 0($sp)
	
	addi $sp, $sp, -56
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)
	sw $fp, 36($sp)
	
	
	
	move $fp, $sp
	
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	move $s4, $t0
	move $s5, $t1


	move $a0, $a2
	li $a1, 0
	li $a2, 0
	li $v0, 13
	
	syscall 
	bltz $v0, liError2
	j no2
	
	liError2:
		li $v0, -1

		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		lw $s4, 20($sp)
		lw $s5, 24($sp)
		lw $s6, 28($sp)
		lw $s7, 32($sp)
		lw $fp, 36($sp)
		addi $sp, $sp, 56
		
		jr $ra
	
	no2:
	sw $v0, 52($fp)
	
	addi $sp, $sp, -400
	
	move $a0, $v0
	move $a1, $sp
	li $a2, 30
	
	li $v0, 14
	syscall
	bltz $v0, liError
	lb $t0, 0($sp)
	lb $t0, 6($sp)
	

	sw $s3, 40($fp)
	sw $s4, 44($fp)
	sw $s5, 48($fp)
	
	li $s1, 0
	
	
	#hitcolor = -20($sp)
	#misscolor = -24($sp)
	#defaultcolor = -28($sp)
	#s3 - #s5 free
	
	#check which player bruh
	#arguments in s0 - s2
	
	
	li $t0, 1
	seq $s3, $s1, $t0
	#s3 = row
	li $s4, 0 #counter
	
	#increment by 6
	li $s5, -6
	lineIteration:
	
		beq $s4, 5, lineIterationDone
		
		
		#calculate the ship address
		li $t5, 6
		mul $t5, $t5, $s4
		add $s5, $sp,$t5 #s5 = beginning of line
		lb $t9, 0($s5)
		li $t2, 5
		mul $s6, $s3, $t2
		add $s6, $s6, $s4
		li $t2,6
		mul $s6, $s6, $t2
		add $s6, $s6, $s0
		#lb $t0, 0($s6)
		lb $t0, 0($s6)
		lb $t0, 1($s6)
		lb $t0, 2($s6)
		lb $t0, 3($s6)
		lb $t0, 4($s6)
		lb $t0, 5($s6)
		
		#s6 = ship address
		#lb $t0, 0($s5)
		
		move $a0, $s5
		move $a1, $s6
		lbu $t0, 40($fp)
		move $a2, $t0
		lbu $t0, 44($fp)
		move $a3, $t0
		lbu $t0, 48($fp)
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		jal getShipInfo
		
		addi $sp, $sp, 4
		
		beq $v0, -1, liError
		
		add $s1, $v0, $s1
		lb $t0, 0($s6)
		lb $t0, 1($s6)
		lb $t0, 2($s6)
		lb $t0, 3($s6)
		lb $t0, 4($s6)
		lb $t0, 5($s6)
		
		
		addi $s4, $s4, 1
		
		j lineIteration
	
	lineIterationDone:
		lw $a0, 52($fp)
		li $v0, 16
		syscall
		move $v0,$s1
		j returnskii
		liError:
			lw $a0, 52($fp)
			li $v0, 16
			syscall
			li $v0, -1
			j returnskii
		
		returnskii:
		
		
		addi $sp, $sp, 400
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		lw $s4, 20($sp)
		lw $s5, 24($sp)
		lw $s6, 28($sp)
		lw $s7, 32($sp)
		lw $fp, 36($sp)
		addi $sp, $sp, 56
		
		
		
		jr $ra
	
	
		
	
	
	
	
	
	

    # Insert implementation her
    

    jr $ra


################### PART 3 ##############################


isHit:
	bltz $a1, isHitError
	bgt $a1, 1, isHitError
	bltz $a2, isHitError
	bgt $a2, 9, isHitError
	bltz $a3, isHitError
	bgt $a3,9, isHitError
	j noHitError
	isHitError:
		li $v0, -1
		li $v1, -1
		jr $ra
    # Insert implementation here
    	noHitError:
    	addi $sp, $sp, -28
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	
    
   	 
   	 li $t0, 0 #counter - increment until hits ten
   	 li $t1, 2 #r0ws
   	 li $t2, 5 #columns
   	 
   	 seq $t3, $a1, $0
   	 
   	 
   	 li $t4, 0
   	 
   	 #t4 = current_col
   	 li $t6, 6
   	 
   	 isHitLoop:
   	 	#calculate the address of the ith ship
   	 	isInner:
   	 		
   	 		beq $t4, $t2, isHitLoopDone
   	 		mul $t5, $t3, $t2
   	 		add $t5, $t5, $t4
   	 		mul $t5, $t5, $t6
   	 		add $t5, $t5, $a0
   	 		
   	 		#t5 = Ship & playerships[i][j]
   	 		
   	 		lb $s0, 2($t5)
   	 		
   	 		beq $s0 ,'D', checkDown
   	 	
   	 		checkRight:
   	 			lb $s1, 1($t5) #start col
   	 			lb $s2, 3($t5) #length
   	 			add $s3, $s1, $s2
   	 				#end column = s3
   	 			
   	 			lb $s4, 0($t5) # start row
   	 			
   	 			beq $s4, $a2, check1
   	 			j nextShip
   	 			
   	 			check1:
   	 				bge $a3, $s1, check2
   	 				j nextShip
   	 				check2:
   	 				ble $a3, $s3, shipHit
   	 			
   	 				j nextShip
   	 		checkDown:
   	 		#make s1 = start row
   	 			#s2 = length
   	 			#s3 = end row
   	 			#s4 = start column
   	 		lb $s1, 0($t5)
   	 		lb $s2, 3($t5)
   	 		add $s3, $s1, $s2
   	 		lb $s4, 1($t5)
   	 		
   	 		beq $a3, $s4, check3
   	 		j nextShip 		
   	 		check3:
   	 			bge $a2, $s1, check4
   	 			j nextShip	
   	 		check4:
   	 			ble $a2, $s3, shipHit
   	 			j nextShip
   	 		shipHit:
   	 		lb $s5 ,4($t5)
   	 		addi $s5, $s5, 1
   	 		sb $s5, 4($t5)
   	 		
   	 		beq $s5, $s2, shipSunk
   	 		li $v0, 1
   	 		li $v1, -1
   	 		j hitReturn
   	 		shipSunk:
   	 			li $v0, 1
   	 			move $v1, $t4
   	 			j hitReturn
   	 			
   	 		
   	 		nextShip:
   	 		addi $t4, $t4, 1
   	 		j isInner
   	 		
   	 		
   	 	
   	 	
   	 	#t2 = address of the ith ship
   	 	
   	 	
   	 	

	isHitLoopDone:
	li $v0, 0
	hitReturn:
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	addi $sp, $sp, 28
		
	jr $ra
	
playerMove:

    bge $a1, 100, playerMoveError
    bltz $a2, playerMoveError
    bgt $a2, 1, playerMoveError
    
    lb $t0, 0($a3)
    blt $t0, 'A', playerMoveError
    bgt $t0, 'J', playerMoveError
    lb $t0, 1($a3)
    blt $t0, '0', playerMoveError
    bgt $t0, '9', playerMoveError
    
    lb $t0, 2($a3)
    bne $t0, 10, playerMoveError
    
    lb $t0, 0($sp)
    lb $t1, 4($sp)
    
    bgt $t0,0xF, playerMoveError
    bgt $t1, 0xF, playerMoveError
    j noPmError
    
    playerMoveError:
    	li $v0, -1
    
    
    noPmError:
    	#prologue
    	
    	addi $sp, $sp, -40
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)
	sw $fp, 36($sp)
	addi $fp, $sp, 40
	
	
	
	#------------------------#
	move $s0, $a0 #moves
	move $s1, $a1 #curMovenum
	move $s2, $a2 #player
	move $s3, $a3 #move
	#(0)fp = misscolor
	#(4)fp = hitcolor
	#(8)fp = playerships
	
    	#seperate move string into row, col values
    	
    	lb $s4, 0($s3)
    	lb $s5, 1($s3)
    	
    	addi $s4, $s4, -65
    	addi $s5, $s5, -48
    	#s4 = move(row)
    	#s5 = move(col)
    	
    	#iterate through moves array
    	li $t0, 1
    	seq $t1, $s2, $t0
    	#$t1 = column
    	li $t0, 0
    	
    	movesLoop:
    		beq $t0, 100, newMove
    		li $t3, 2
    		
    		#calculate moves[i]
    		mul $t2, $t0, $t3
    		add $t2, $t2, $t1
    		sll $t2, $t2, 1
    		add $t2, $t2, $s0
    		lh $t2, 0($t2)
    		
    		#$t2 = move [i][j]
    		
    		#t4 will equal rowcol in bits
    		sll $t4, $s4, 4
    		or $t4, $t4, $s5
    		#t4 = move bitvector
    		move $s6, $t4
    		
    		li $t5, 0xFF
    		and $t5, $t5, $t2
    		#t5 = bitvector [i][j] without flag
    		
    		beq $t4, $t5,pmError 
    		j skipy
    		
    		
    		pmError:
    			li $v0, -1
    			
			lw $ra, 0($sp)
			lw $s0, 4($sp)
			lw $s1, 8($sp)
			lw $s2, 12($sp)
			lw $s3, 16($sp)
			lw $s4, 20($sp)
			lw $s5, 24($sp)
			lw $s6, 28($sp)
			lw $s7, 32($sp)
			lw $fp, 36($sp)
			addi $sp, $sp, 40
			jr $ra
			
			
			
			
		skipy:
			addi $t0, $t0, 1
			j movesLoop
			
			
			
    		
    		
    		
    		
    		newMove:
    		#s6 = move bitvector
    		lw $a0, 8($fp)
    		move $a1, $s2
    		move $a2, $s4
    		move $a3, $s5


    		jal isHit
    		
    		beq $v0, 1, hit
    		j notHit
    		
    		hit:
    		li $t0, 0x100
    		or $s6, $s6, $t0
    		
    		#s6 = move bitvector with flag
    		move $s7, $v1
    			#change fg
    			li $a0, 0
    			move $a1, $s4
    			move $a2, $s5
    			jal getColor
    			
    			li $t0, 0xF0
    			and $t0, $t0, $v0
    			lb $t1, 4($fp)
    			
    			or $t9, $t0, $t1
    			
    			
 
    			li $a0, 0
    			move $a1, $s4
    			move $a2, $s5
    			li $a3, 72
    			lb $t0, 4($fp)
    			addi $sp, $sp, -4
    			sb $t9, 0($sp)
    			jal setCell
    			addi $sp, $sp, 4
    			
    			bgt $s7, -1, andSunk
    			li $v0, 1
    			li $v1, -1
    			j setMove
    			
    			andSunk:
    				#calc ship address
    				li $t1, 5
    				mul $t0, $s2, $t1
    				add $t0, $t0, $s7
    				li $t1, 6
    				mul $t0, $t0, $t1
    				lw $t1, 8($fp)
    				add $t0, $t1, $t0
    				move $a1, $t0
    				li $a0, 0
    				jal drawShip
    				li $v0, 1
    				move $v1, $s7
    				j setMove
    			
    				
    					
    		notHit:
    			li $a0, 0
    			move $a1, $s4
    			move $a2, $s5
    			jal getColor
    			
    			li $t0, 0xF0
    			and $t0, $t0, $v0
    			lb $t1, 4($fp)
    			
    			or $t9, $t0, $t1
    			li $a0, 0
    			move $a1, $s4
    			move $a2, $s5
    			li $a3, 77
    			lb $t0, 0($fp)
    			addi $sp, $sp, -4
    			sb $t9, 0($sp)
    			jal setCell
    			addi $sp, $sp, 4
    			li $v0, 0
    						
    				#t0 = row
    			setMove:
    			# set s6 at moves
    			sll $t0, $s1, 1
    			add $t0, $t0, $s2
    			sll $t0, $t0, 1
    			add $t0, $s0, $t0
    			sh $s6, 0($t0)
 
			lw $ra, 0($sp)
			lw $s0, 4($sp)
			lw $s1, 8($sp)
			lw $s2, 12($sp)
			lw $s3, 16($sp)
			lw $s4, 20($sp)
			lw $s5, 24($sp)
			lw $s6, 28($sp)
			lw $s7, 32($sp)
			lw $fp, 36($sp)
			addi $sp, $sp, 40
    			
    			jr $ra	
    		
    	
    	
    		
    	
    	



loadBoards:

    bltz $a0, lbError
    bgt $a0, 1, lbError
    
    bge $a3, 100, lbError
    
    lb $t0, 0($sp)
    bgt $t0, 0xF, lbError
    
    lb $t0, 4($sp)
    bgt $t0, 0xF, lbError
    
    lb $t0, 8($sp)
    bgt $t0, 0xF, lbError
    
    
    
    j noLbError
    
    lbError:
    	li $v0, -1
    	jr $ra
    
    noLbError:
    	#prolog
    	addi $sp, $sp, -52
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)
	sw $fp, 36($sp)
	#40
	#44
	#48
	addi $fp, $sp, 52
	
	
	#--------------#
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	
	
	#upper board
	li $a0, 0
	li $a1, 0x8F
	li $a2, 0
	jal fillBoard
	
	
	#iterate through previous moves
	li $t0, 1
	seq $s4, $s0, $t0
	  #s4 = column
	
	li $s5, 0 #rows
	
	loadBoardLoop1:
		beq $s5, $s3, loop1Done
		
		#calculate moves
		
		sll $s6, $s5, 1
		add $s6, $s6, $s4
		sll $s6, $s6, 1
		add $s6, $s6, $s2
		
		lh $s6, 0($s6)
			#s6 = bitvector
		 li $t0, 0xF
		 and $s7, $s6, $t0
		 	#$s7 = column
		 li $t0, 0xF0
		 and $t1, $s6, $t0
		 srl $t1, $t1, 4
		 	#t1 = row
		 	sw $t1, 40($sp)
		 li $t0, 0xF00
		 srl $t2, $s6, 8
		 	#t2 = flag
		 	sw $t2, 44($sp)
		 
		 li $a0, 0
		 move $a1, $t1
		 move $a2, $s7
		  
		 jal getColor
		 li $t0, 0xF0
		 and $t3, $t0, $v0
		 #t3 = bg	 
		 
		 lb $t2, 44($sp)
		 beqz $t2, missed	 
		
		  lb $t1, 8($fp) 
		 
		 or $t3, $t3, $t1
		 	#t3 = bg and fg
		 li $a0, 0
		 sw $a1, 40($sp)
		 move $a2, $s7
		 li $a3, 72
		 addi $sp, $sp, -4
		 sb $t3, 0($sp)
		 jal setCell
		 addi $sp, $sp, 4
		 
		 j nxxxt
		 missed:
		 	lb $t1, 4($fp) 
		 	or $t3, $t3, $t1
		 	li $a0, 0
		 	sw $a1, 40($sp)
			 move $a2, $s7
			 li $a3, 77
			 addi $sp, $sp, -4
			 sb $t3, 0($sp)
			 jal setCell
			 addi $sp, $sp, 4
		nxxxt:
			addi $s5, $s5, 1
			j loadBoardLoop1
	loop1Done:
		
		seq $s4, $s0, $0
		li $a0, 0
		move $a1, $s1
		move $a2, $s4
		li $a3, 1
	
	#lower board
	lb $t0, 0($fp)
	sll $t0, $t0, 4
	ori $t0, $t0, 0xF
		#t0 = color
	
	
	
	li $a0, 1
	move $a1, $t0
	li $a2, 87
	
	jal fillBoard
	
	li $a0, 1
	move $a1, $s1
	move $a2, $s0
	li $a3, 0
	
	jal displayShips
	
	
	li $t0, 1
	seq $s4, $s0, $t0
	  #s4 = column
	
	li $s5, 0 #rows
	
	loadBoardLoop2:
		beq $s5, $s3, loop2Done
		
		#calculate moves
		
		sll $s6, $s5, 1
		add $s6, $s6, $s4
		sll $s6, $s6, 1
		add $s6, $s6, $s2
		
		lh $s6, 0($s6)
			#s6 = bitvector
		 li $t0, 0xF
		 and $s7, $s6, $t0
		 	#$s7 = column
		 li $t0, 0xF0
		 and $t1, $s6, $t0
		 srl $t1, $t1, 4
		 	#t1 = row
		 	sw $t1, 40($sp)
		 li $t0, 0xF00
		 srl $t2, $s6, 8
		 	#t2 = flag
		 	sw $t2, 44($sp)
		 
		 li $a0, 1
		 move $a1, $t1
		 move $a2, $s7
		  
		 jal getColor
		 li $t0, 0xF0
		 and $t3, $t0, $v0
		 #t3 = bg	 
		 
		 lb $t2, 44($sp)
		 beqz $t2, missed2
		
		  lb $t1, 8($fp) 
		 
		 or $t3, $t3, $t1
		 	#t3 = bg and fg
		 li $a0, 1
		 sw $a1, 40($sp)
		 move $a2, $s7
		 li $a3, 72
		 addi $sp, $sp, -4
		 sb $t3, 0($sp)
		 jal setCell
		 addi $sp, $sp, 4
		 
		 j nxxxt2
		 missed2:
		 	lb $t1, 4($fp) 
		 	or $t3, $t3, $t1
		 	li $a0, 1
		 	sw $a1, 40($sp)
			 move $a2, $s7
			 li $a3, 77
			 addi $sp, $sp, -4
			 sb $t3, 0($sp)
			 jal setCell
			 addi $sp, $sp, 4
		nxxxt2:
			addi $s5, $s5, 1
			j loadBoardLoop2
	loop2Done:
		li $v0, 0
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		lw $s4, 20($sp)
		lw $s5, 24($sp)
		lw $s6, 28($sp)
		lw $s7, 32($sp)
		lw $fp, 36($sp)
		addi $sp, $sp, 52
		
		jr $ra
		
	
	