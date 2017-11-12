# PROGRAM: ASSIGNMENT 1
# Variables:
# ----------
# MAIN
# $s0 Cumulative Sum - cumulativeSum
# $s1 Exponent - exponent
#
# 
# CHECKDATA
# $t0 Current digit address - curAdd
# $t1 Current digit - curDigit
# $t2 Digit counter - digitCount
# $t3 Invalid number flag - invalFlag
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
#	jal CheckData #Verifies if userInput is a valid HEX value
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
	
checkData:
	la $t0, userInput #sets digit address to leftmost slot
	checkDataLoop:
		
		addi $t0, $t0, 1 #shifts attention to next digit
		lb $t1, 0($t0) #loads new digit 
	jr $ra
