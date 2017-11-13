# PROGRAM: ASSIGNMENT 1
# Variables:
# ----------
# MAIN
# $s0 CONST End of string - NULL
# $s1 CONST Maximum size of string - STRSIZE
# $s2 CONST Input Base - INBASE
# $s3 CONST Output Base - OUTBASE
# $t0 Cumulative sum - cumulativeSum
# $t1 Address of decimal in string form - deciString
#
#
# 
# CHECKDATA
# $a0 Starting address of string - argument1
# $t0 Current digit address - curAdd
# $t1 Current digit - curDigit
# $t2 Digit counter - digitCount
# $t3 Current digit invalid flag - digiInvalFlag
# $t4 Invalid number flag - invalFlag
# $t5 Current ascii limit - curLim
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
	
	inputErrorText:
		.asciiz "\n\nInvalid entry [0-9,A-F, or a-f ONLY]\n\n"
		
	outputStatement:
		.asciiz "Decimal value: "
	
	outputDecimal:
		.space 10 #Largest expected value is 4294967295 (FFFFFFFF); 10 digits long
	
	.text #Assembly instructions component
main: #Start of code
	#variables intialized
	li $s0, 10 #CONST NULL = 10
	li $s1, 8 #CONST STRSIZE = 8
	li $s2, 16 #CONST INBASE = 16
	li $s3, 10 #CONST OUTBASE = 10
input:
	la $a0, inputPrompt #Set output source to newLine
	li $v0, 4 #Output String code loaded
	syscall	#Output string
	li $a1, 10 #Specify max size for read string
	la $a0, userInput #Set destination for read string
	li $v0, 8 #Read String code loaded
	syscall #Read string from user
	
validityCheck:
	jal CheckData #Verifies if userInput is a valid HEX value
	bne $v0, $zero, inputError

decimalConversion:
	la $a0, userInput
	jal CalcuateDecimal
	add $t0, $v0, $zero
	
stringConversion:
	add $a0, $t0, $zero
	jal ConvertDecimalToString
	add $t1, $v0, $zero
	
output:
	la $a0, newLine #Set output source to newLine
	li $v0, 4 #Output String code loaded
	syscall	#Output string
	la $a0, outputStatement #Set output source to outputStatement
	li $v0, 4 #Output String code loaded
	syscall	#Output string
	add $a0, $t1, $zero #Set output source to cumulativeSum
	li $v0, 4 #Output Unsigned Integer code loaded
	syscall	#Output signed integer
	
exit:
	li $v0, 10 #Exit code loaded
	syscall	#Exit program
	
inputError:
	la $a0, inputErrorText #Set output source to newLine
	li $v0, 4 #Output String code loaded
	syscall	#Output string
	j input

# CHECKDATA
# $a0 Starting address of string - argument1
# $t0 Current digit address - curAdd
# $t1 Current digit - curDigit
# $t2 Digit counter - digitCount
# $t3 Current digit invalid flag - digiInvalFlag
# $t4 Invalid number flag - invalFlag
# $t5 Current ascii limit - curLim
# $v0 $t3, Invalid number flag - returnVar1
	
CheckData:
	add $t0, $a0, $zero #sets digit address to leftmost slot
	li $t2, 0 #initializes digit counter to zero
	li $t4, 0 #initializes invalFlag to zero
	li $t3, 0 #initializes digiInvalFlag to zero
	checkDataLoop:
		lb $t1, 0($t0) #loads new digit 
		beq $t1, $s0, CheckDataEnd #If the value is End-of-String, exit loop
		ifNotNull: #if(curDigit != NULL)
			la $a0, space #Set output source to newLine
			li $v0, 4 #Output String code loaded
			syscall	#Output string
			add $a0, $t1, $zero
			li $v0, 1 #Output Integer code loaded
			syscall	#Output integer
			numberTest:
				li $t5, 47 #set curLim to "0" - 1
				slt $t3, $t1, $t5 #return 1 if digit is less than "0"
				bne $t3, $zero, AddToInvalFlag
				li $t5, 57 #set curLim to "9"
				slt $t3, $t5, $t1 #return 1 if "9" is less than digit
				beq $t3, $zero, AddToInvalFlag #digit is between "0" and "9"
			
			upperCaseTest:
				li $t5, 64 #set curLim to "A" - 1
				slt $t3, $t1, $t5 #return 1 if digit is less than "A"
				bne $t3, $zero, AddToInvalFlag
				li $t5, 70 #set curLim to "F"
				slt $t3, $t5, $t1 #return 1 if "F" is less than digit
				beq $t3, $zero, AddToInvalFlag
				
			lowerCaseTest:
				li $t5, 96 #set curLim to "a" - 1
				slt $t3, $t1, $t5 #return 1 if digit is less than "A"
				bne $t3, $zero, AddToInvalFlag
				li $t5, 102 #set curLim to "f"
				slt $t3, $t5, $t1 #return 1 if "F" is less than digit
				beq $t3, $zero, AddToInvalFlag
	AddToInvalFlag:
		or $t4, $t3, $t4 #updates overall flag based on current digit check
		bne $t4, $zero, CheckDataEnd #ends loop early if invalid number is found
		addi $t0, $t0, 1 #shifts attention to next digit
		addi $t2, $t2, 1 #increment digit counter
		bne $s1, $t2, checkDataLoop #while digitCount != STRSIZE
	
	la $a0, newLine #Set output source to newLine
	li $v0, 4 #Output String code loaded
	syscall	#Output string
	
	CheckDataEnd:	
		add $v0, $t4, $zero #load status into return value, v0
		jr $ra #end of function

# CALCULATEDECIMAL
# $a0 Starting address of string - argument1
# $t0 Current digit address - curAdd
# $t1 Current digit - curDigit
# $t2 Digit counter - digitCount
# $t3 Exponent progress tracker - expCounter
# $t4 Multiplier - multiplier
# $t5 Tracks maximum exponent of current digit - expMax
# $t6 Digit decimal value - digiVal
# $t7 Cumulative sum - cumulativeSum
# $t8 Temp const holder - tempConstHolder
# $v0 $t7, cumulative sum - returnVar1

CalcuateDecimal:
	add $t0, $a0, $zero #sets digit address to leftmost slot
	li $t2, 0 #initializes digit counter to zero
	
	totalDigitsLoop:
		lb $t1, 0($t0) #loads new digit 
		beq $t1, $s0, totalDigitsLoopEnd #If the value is null
		beq $t2, $s1, totalDigitsLoopEnd #If counter = max string size
		addi $t0, $t0, 1 #shifts attention to next digit
		addi $t2, $t2, 1 #increment digit counter
		j totalDigitsLoop
	
	totalDigitsLoopEnd:
		sub	$t0, $t0, $t2 #resets pointer to start of string
		lb $t1, 0($t0) #loads new digit; loads 10 if empty string
	
		li $t7, 0 #cumulativeSum = 0
		addi $t5, $t2, -1 #starts expMax at maximum exponent (n-1)
		beq $t1, $s0, addDecimalDigitsLoopEnd #skips process and returns 0 if input is empty string
		addDecimalDigitsLoop:
			li $t3, 0 #expCounter = 0
			li $t4, 1 #multiplier = 1
			multiplierLoop:
				beq $t3, $t5, multiplierLoopEnd #execute until the multiplier is multiplied by 16^expMax
				mult $t4, $s2 #multiply by 16 (effectively raise by a power)
				mflo $t4 #load result of multiplier * 16
				addi $t3, $t3, 1 #increment exponent counter
				j multiplierLoop
			multiplierLoopEnd:
			translateCharToInt:
				li $t8, 58 #set curLim to "9" + 1
				slt $t8, $t8, $t1  #return 1 if "9" is less than digit
				bne $t8, $zero, notDigit
				addi $t1, $t1, -48 #lower value so that "0" = 0
				j applyMultiplier
				notDigit:
					li $t8, 71 #set curLim to "F" + 1
					slt $t8, $t8, $t1 #return 1 if "9" is less than digit
					bne $t8, $zero, notUpper
					addi $t1, $t1, -55 #lower value so that "A" = 10
				j applyMultiplier
				notUpper:
					li $t8, 103 #set curLim to "f" + 1
					slt $t8, $t8, $t1 #return 1 if "9" is less than digit
					addi $t1, $t1, -87 #lower value so that "a" = 10
			applyMultiplier:
				mult $t4, $t1 #multiplier * digit value
				mflo $t6 #loads result of multiplier * digit value
				add $t7, $t7, $t6 #adds digit decimal value to cumulativeSum
				addi $t5, $t5, -1 #lowers expMax ceiling
				li $t8, -1 #loads lowest expMax case
				beq $t8, $t5, addDecimalDigitsLoopEnd #exits if expMax drops below 0
				addi $t0, $t0, 1 #shifts attention to next digit
				lb $t1, 0($t0) #loads next digit
				j addDecimalDigitsLoop
		addDecimalDigitsLoopEnd:
			add $v0, $t7, $zero
			jr $ra #end of function
		

# CONVERTDECIMALTOSTRING
# $a0 Decimal to convert
# $a1 Size of decimal
# $t0 $a0, Decimal to convert - deciVal
# $t1 Destination string of converted decimal - deciString
# $t2 deciVal mod 10 - modResult
# $t3 
# $t4 Multiplier - multiplier
# $t5 Tracks maximum exponent of current digit - expMax
# $t6 Digit decimal value - digiVal
# $t7 Cumulative sum - cumulativeSum
# $t8 Temp const holder - tempConstHolder
# $v0 Destination string of converted decimal - returnVar1		
		
ConvertDecimalToString:
	add $t0, $a0, $zero
	la $t1, outputDecimal
	addi $t1, $t1, 10 #shift attention to the end of the string
	addi $t1, $t1, -1
	add $t2, $s0, $zero
	addToString:
		divu $t0, $s3
		mfhi $t2
		mflo $t0
		addi $t2, $t2, 48 #raise value so that 0 = "0"
		sb $t2, 0($t1)
		addi $t1, $t1, -1
		bne $t0, $zero, addToString
	addi $t1, $t1, 1
	add $v0, $t1, $zero
	jr $ra #end of function
