# PROGRAM: ASSIGNMENT 1
# Variables:
# ----------
# MAIN
# $s0 Cumulative Sum - cumulativeSum
# $s1 Exponent - exponent
#
# 
# CHECKDATA
# $a0 Starting address of string - argument1
# $t0 Current digit address - curAdd
# $t1 Current digit - curDigit
# $t2 Digit counter - digitCount
# $t3 Invalid number flag - invalFlag
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
	li $s0, 0 #cumulativeSum = 0
	li $s1, 0 #exponent = 0
	li $s2, 0 #curDigit = 0
	
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
	add $a0, $s0, $zero #Set output source to cumulativeSum
	li $v0, 1 #Output Integer code loaded
	syscall	#Output integer
exit:
	li $v0, 10 #Exit code loaded
	syscall	#Exit program
	
CheckData:
	add $t0, $a0, $zero #sets digit address to leftmost slot
	checkDataLoop:
		addi $t0, $t0, 1 #shifts attention to next digit
		lb $t1, 0($t0) #loads new digit
		slti $t3, $t1, 47
	add $v0, $t3, $zero #load status into return value, v0
	jr $ra #end of function
