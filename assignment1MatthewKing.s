# PROGRAM: ASSIGNMENT 1
	.data #Data declaration component
	userInput:
		.space 8 #8 bytes, 1 byte per possible character; Space is maximum size
	
	.text #Assembly instructions component
main: #Start of code

	li $a1, 9 #Specify max size for read string
	la $a0, userInput #Set destination for read string
	li $v0, 8 #Read String code loaded
	syscall #Read string from user
	
	la $t0, userInput
	lb $t1, 0($t0)
	add $a0, $t1, $zero
	li $v0, 11 #Output character code loaded
	syscall	#Output string
	lb $t1, 7($t0)
	add $a0, $t1, $zero
	li $v0, 11 #Output character code loaded
	syscall	#Output string
	
	la $a0, userInput #Set source for output string
	li $v0, 4 #Output String code loaded
	syscall	#Output string

exit:
	li $v0, 10 #Exit code loaded
	syscall	#Exit program
