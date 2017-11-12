# PROGRAM: ASSIGNMENT 1
# Variables:
# ----------
# MAIN
# $s0 CONST End of string - NULL
# $s1 CONST Maximum size of string - STRSIZE
# $s2 
# $s6 Cumulative sum - cumulativeSum
# $s7 Exponent - exponent
# 
# CHECKDATA
# $a0 Starting address of string - argument1
# $t0 Current digit address - curAdd
# $t1 Current digit - curDigit
# $t2 Digit counter - digitCount
# $t3 Current digit invalid flag - digiInvalFlag
# $t4 Invalid number flag - invalFlag
# $v0 $t3, Invalid number flag - returnVar1
################################################################
	.data #Data declaration component
	userInput:
		.space 8 #8 bytes, 1 byte per possible character; Space is maximum size
	
	newLine:
		.asciiz "\n"
	
	space:
		.asciiz " "
		
	inputPrompt:
		.asciiz "Please enter a hexadecimal number:\n"
		
	outputStatement:
		.asciiz "Decimal value: "
	
	.text #Assembly instructions component
main: #Start of code
	#variables intialized
	li $s0, 10 #CONST NULL = 10
	li $s1, 8 #CONST STRSIZE = 8
	li $s6, 0 #cumulativeSum = 0
	li $s7, 0 #exponent = 0
	
input:
	li $a1, 10 #Specify max size for read string
	la $a0, userInput #Set destination for read string
	li $v0, 8 #Read String code loaded
	syscall #Read string from user
	
validityCheck:
	jal CheckData #Verifies if userInput is a valid HEX value
	add $a0, $v0, $zero #tests function result
	li $v0, 1 #Output Integer code loaded
	syscall	#Output integer
	
output:
	la $a0, outputStatement #Set output source to outputStatement
	li $v0, 4 #Output String code loaded
	syscall	#Output string
	add $a0, $s6, $zero #Set output source to cumulativeSum
	li $v0, 1 #Output Integer code loaded
	syscall	#Output integer
	
exit:
	li $v0, 10 #Exit code loaded
	syscall	#Exit program

# CHECKDATA
# $a0 Starting address of string - argument1
# $t0 Current digit address - curAdd
# $t1 Current digit - curDigit
# $t2 Digit counter - digitCount
# $t3 Current digit invalid flag - digiInvalFlag
# $t4 Invalid number flag - invalFlag
# $v0 $t3, Invalid number flag - returnVar1
	
CheckData:
	add $t0, $a0, $zero #sets digit address to leftmost slot
	li $t2, 0 #initializes digit counter to zero
	li $t4, 0 #initializes invalFlag to zero
	li $t3, 0 #initializes digiInvalFlag to zero
	checkDataLoop:
		lb $t1, 0($t0) #loads new digit 
		beq $t1, $s0, CheckDataEnd
		
		add $a0, $t1, $zero #Set output source to cumulativeSum
		li $v0, 1 #Output Integer code loaded
		syscall	#Output integer
		la $a0, space #Set output source to space
		li $v0, 4 #Output String code loaded
		syscall	#Output string
		
		beq $zero, $t3, orSkip
		
		ifNotNull: #if(curDigit != NULL)
			slti $t3, $t1, 47
	orSkip:
		or $t4, $t3, $t4
		addi $t0, $t0, 1 #shifts attention to next digit
		addi $t2, $t2, 1 #increment digit counter
		bne $s1, $t2, checkDataLoop #while digitCount != STRSIZE
	
	la $a0, newLine #Set output source to newLine
	li $v0, 4 #Output String code loaded
	syscall	#Output string
	
	CheckDataEnd:	
		add $v0, $t4, $zero #load status into return value, v0
		jr $ra #end of function
