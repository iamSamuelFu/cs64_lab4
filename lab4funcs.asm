

# xSpim Memory Demo Program

# Data Area.  Note that while this is typically only
# For global immutable data, for SPIM, this also includes
# mutable data.        
.data

welcome:
	.asciiz "This program loads, stores, and operates on variables\nLooking at the comments in the code, perform the operations specified.  Make sure you make changes to this code in order to test it.  You can change the initial values of variables as well as the inputs you test."

initial1:
	.asciiz "\nGlobal variable values are: "

initial2:
	.asciiz "\nArray values are: "

initial3:
	.asciiz "\nregister values are: "

comma:
	.asciiz ", "

enter:
	.asciiz "\nEnter a value: "

question:
	.asciiz "What functions would you like to test? "

# global variables
globalA:
        .word 0x23
globalB:
        .word 0x27
globalC:
        .word 0x36
globalD:
        .word 0x5a

# myArray declaration allocates & initializes a 9 integer array,
myArray:
        .word 0x20030112 0x200202f1 0x100b00a1 0x6b502a
        .word 0x15400003 0x1084020 0x20840000 0x800fffa
        .word 0x1001020

#Text Area (i.e. instructions)
.text

main:

	# Display the welcome message;  lui and ori constants are obtained
	#  manually from the global symbol table.  One will surely appreciate
	#  the la pseudoinstruction after this exercise.
	ori     $v0, $0, 4			
	la     $a0, welcome
	syscall

	add $a0, $0, $0
	add $a1, $0, $0
	add $a2, $0, $0
	add $a3, $0, $0
	jal printvalues

	# ask which question to test
	ori     $v0, $0, 4			
	la     $a0, enter
	syscall
        # read number
        ori     $v0, $0, 5
        syscall
	add	$s7, $v0, $0
 	

	# wipe regs clean
	add $a0, $0, $0
	add $a1, $0, $0
	add $a2, $0, $0
	add $a3, $0, $0
	add $v0, $0, $0
	add $v1, $0, $0
	add $a0, $0, $0
	add $a1, $0, $0
	add $a2, $0, $0
	add $a3, $0, $0
	add $t0, $0, $0
	add $t1, $0, $0
	add $t2, $0, $0
	add $t3, $0, $0
	add $t4, $0, $0
	add $t5, $0, $0
	add $t6, $0, $0
	add $t7, $0, $0
	add $s6, $0, $0
	add $s5, $0, $0
	add $s4, $0, $0
	add $s3, $0, $0
	add $s2, $0, $0
	add $s1, $0, $0
	add $s0, $0, $0

	# print out which they are going to call
	ori     $v0, $0, 1			
	add	$a0, $s7, $0
	syscall
	add $a0, $0, $0
	add $a1, $0, $0
	add $a2, $0, $0
	add $a3, $0, $0

	addi $t0, $0, 1
	slt $t1, $s7, $t0
	beq $t1, $0, F1
	# first function call
	jal storevalues
	jal printvalues
	j end

F1:	addi $t0, $t0, 1
	slt $t1, $s7, $t0
	beq $t1, $0, F2
	addi $a0, $0, 23
	addi $a1, $0, 155
	addi $a2, $0, 33
	addi $a3, $0, 74
	jal printregs
	jal storeregvalues
	jal printvalues
	j end

F2:	addi $t0, $t0, 1
	slt $t1, $s7, $t0
	beq $t1, $0, F3
	jal copyvalues
	jal printvalues
	j end

F3:	addi $t0, $t0, 1
	slt $t1, $s7, $t0
	beq $t1, $0, F4
	jal operations
	jal printvalues
	j end

F4:	addi $t0, $t0, 1
	slt $t1, $s7, $t0
	beq $t1, $0, F5
	addi $a0, $0, 9
	addi $a1, $0, 6
	jal printregs
	jal arrays
	jal printvalues
	j end

F5:	jal arraycalcs
	jal printvalues
	j end

end:
	# Exit
	ori     $v0, $0, 10
	syscall

printregs:
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	# print out the initial values
	ori     $v0, $0, 4			
	la     $a0, initial3
	syscall
	# load and print out globalA
	ori     $v0, $0, 1			
	lw	$a0, 4($sp)
	syscall
	# print a comma
	ori     $v0, $0, 4			
	la     $a0, comma
	syscall
	# load and print out globalA
	ori     $v0, $0, 1			
	lw	$a0, 8($sp)
	syscall
	# print a comma
	ori     $v0, $0, 4			
	la     $a0, comma
	syscall
	# load and print out globalA
	ori     $v0, $0, 1			
	lw	$a0, 12($sp)
	syscall
	# print a comma
	ori     $v0, $0, 4			
	la     $a0, comma
	syscall
	# load and print out globalA
	ori     $v0, $0, 1			
	lw	$a0, 16($sp)
	syscall

	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 24
	jr $ra

printvalues:
	addi $sp, $sp, -16
	sw $ra, 0($sp)
	# print out the initial values
	ori     $v0, $0, 4			
	la     $a0, initial1
	syscall
	# load and print out globalA
	ori     $v0, $0, 1			
	la	$t0, globalA
	lw	$a0, 0($t0)
	syscall
	# print a comma
	ori     $v0, $0, 4			
	la     $a0, comma
	syscall
	# load and print out globalB
	ori     $v0, $0, 1			
	la	$t0, globalB
	lw	$a0, 0($t0)
	syscall
	# print a comma
	ori     $v0, $0, 4			
	la     $a0, comma
	syscall
	# load and print out globalC
	ori     $v0, $0, 1			
	la	$t0, globalC
	lw	$a0, 0($t0)
	syscall
	# print a comma
	ori     $v0, $0, 4			
	la     $a0, comma
	syscall
	# load and print out globalD
	ori     $v0, $0, 1			
	la	$t0, globalD
	lw	$a0, 0($t0)
	syscall


	# print out the array values
	ori     $v0, $0, 4			
	la     $a0, initial2
	syscall
	# load and print out myArray[0]
	ori     $v0, $0, 1			
	la	$s0, myArray
	lw	$a0, 0($s0)
	syscall
	# print a comma
	ori     $v0, $0, 4			
	la     $a0, comma
	syscall
	# load and print out myArray[1]
	ori     $v0, $0, 1			
	lw	$a0, 4($s0)
	syscall
	# print a comma
	ori     $v0, $0, 4			
	la     $a0, comma
	syscall
	# load and print out myArray[2]
	ori     $v0, $0, 1			
	lw	$a0, 8($s0)
	syscall
	# print a comma
	ori     $v0, $0, 4			
	la     $a0, comma
	syscall
	# load and print out myArray[3]
	ori     $v0, $0, 1			
	lw	$a0, 12($s0)
	syscall
	lw $ra, 0($sp)
	addi $sp, $sp, 16
	jr $ra


# COPYFROMHERE - DO NOT REMOVE THIS LINE

storevalues:

        # TODO: translate each line into mips
        # use only regs $v0-$v1, $t0-$t7, $a0-$a3
        # you may assume nothing about their starting values

        # globalA = 6
    la $t0, globalA
    li $t1, 6
    sw $t1, 0($t0)
        # globalB = 6
    la $t2, globalB
    li $t3, 6
    sw $t3, 0($t2)
        # globalC = 30
    la $t4, globalC
    li $t5, 30
    sw $t5, 0($t4)
        # globalD = 30
    la $t6, globalD
    li $t7, 30
    sw $t7, 0($t6)
        # do not remove this line
        jr $ra

storeregvalues:
        # TODO:  In this case, instead of storing constants,
        # we are storing register values into the variables
        # use only regs $v0-$v1, $t0-$t7,
        # you may assume that $a0-$a3 have already been set

        # globalA = $a0
    la $t0, globalA
    sw $a0, 0($t0)
        # globalB = $a1
    la $t1, globalB
    sw $a1, 0($t1)
        # globalC = $a2
    la $t2, globalC
    sw $a2, 0($t2)
        # globalD = $a3
    la $t3, globalD
    sw $a3, 0($t3)

        # do not remove this line
        jr $ra


copyvalues:
        # TODO: translate each line into mips
        # use only regs $v0-$v1, $t0-$t7, $a0-$a3
        # you may assume nothing about their starting values

        # globalA = globalC
    la $t0, globalA
    la $t1, globalC
    lw $t2, 0($t1)
    sw $t2, 0($t0)
        # globalD = globalB
    la $t3, globalD
    la $t4, globalB
    lw $t5, 0($t4)
    sw $t5, 0($t3)
        # do not remove this line
        jr $ra


operations:
        # TODO: translate each line into mips
        # use only regs $v0-$v1, $t0-$t7, $a0-$a3
        # you may assume nothing about their starting values

        # globalA = globalB + globalC
    la $t0, globalA
    la $t1, globalB
    la $t2, globalC
    lw $t3, 0($t1)
    lw $t4, 0($t2)
    addu $t5, $t4, $t3
    sw $t5, 0($t0)
        # globalD = globalA + globalB
    la $t6, globalD
    lw $t7, 0($t6)
    addu $t7, $t5, $t3
    sw $t7, 0($t6)
        # do not remove this line
        jr $ra


arrays:
        # TODO: translate each line into mips
        # use only regs $v0-$v1, $t0-$t7, $a2-$a3
        # you may assume nothing about their starting values
        # $a0 and $a1 have already been set for you

        #myArray[2] = globalA
    li $t0, 2
    la $t1, myArray
    sll $t3, $t0, 2
    addu $t4, $t3, $t1
    la $t5, globalA
    lw $t6, 0($t5)
    sw $t6, 0($t4)
        #globalA = myArray[3]
    li $t0, 3 
    sll $t3, $t0, 2
    addu $t4, $t1, $t3
    lw $t7, 0($t4)
    sw $t7, 0($t5)
        #myArray[0] = $a0
    li $t0, 0
    sll $t3, $t0, 2
    addu $t4, $t1, $t3
    sw $a0, 0($t4)
        #myArray[1] = $a1
    li $t0, 1
    sll $t3, $t0, 2
    addu $t4, $t1, $t3
    sw $a1, 0($t4)
        # do not remove this line
        jr $ra

arraycalcs:
        # TODO: translate each line into mips
        # use only regs $v0-$v1, $t0-$t7, $a0-$a3
        # you may assume nothing about their starting values

        # globalA = myArray[0] + myArray[1]
    li $t0, 0
    la $t1, myArray
    sll $t2, $t0, 2
    addu $t3, $t2, $t1
    lw $t4, 0($t3)
    li $t0, 1
    sll $t5, $t0, 2
    addu $t3, $t5, $t1
    lw $t6, 0($t3)
    addu $t6, $t6, $t4
    la $t7, globalA
    sw $t6, 0($t7)
        # do not remove this line
        jr $ra


