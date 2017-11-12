# PROGRAM: ASSIGNMENT 1
# Variables:
# ----------
# $s0 Cumulative Sum - cumulativeSum
# $s1 Exponent - exponent
# $s2 Current digit - curDigit
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

	li $a1, 10 #Specify max size for read string
	la $a0, userInput #Set destination for read string
	li $v0, 8 #Read String code loaded
	syscall #Read string from user
	
	la $t0, userInput
	lb $t1, 0($t0)
	add $a0, $t1, $zero
	li $v0, 11 #Output character code loaded
	syscall
	
	la $t0, space
	lb $t1, 0($t0)
	add $a0, $t1, $zero
	li $v0, 11 #Output character code loaded
	syscall	#Output string
	
	la $t0, userInput
	lb $t1, 7($t0)
	add $a0, $t1, $zero
	li $v0, 11 #Output character code loaded
	syscall	#Output string
	
	la $a0, newLine #Set source for output string
	li $v0, 4 #Output String code loaded
	syscall	#Output string
	
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
