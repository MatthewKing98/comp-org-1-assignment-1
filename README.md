# comp-org-1-assignment-1
MIPS Programming Assignment 1

ASSIGNMENT 1 ALGORITHM:


START
1. CumulativeSum = 0
2. Exponent = 0
3. Accept input from user
4. Check if data is valid
	4.1 Contains numbers and/or letters going from 0-9 AND (a-f)/(A-F)
5. If data is valid THEN
	5.1 While there is content (while STRING != 000....000)
		5.1.1 Take the rightmost character from the string
		5.1.2 Translate it to decimal
		5.1.3 Multiply it by 16^Exponent
		5.1.4 Add it to CumulativeSum
		5.1.5 Add 1 to Exponent
	5.2 Return CumulativeSum
ELSE
	Repeat 3

	
Thoughts
--------
String stores contents as 1 byte = 1 character
Characters are represented through ascii/unicode
To identify if a character is valid, compare the character in question to decimal values greater than or less than the allowed range.
Cycle for each character.
Must accound for values < 8 characters long
Values shorter than 8 are left-aligned meaning you will have to make exponent inc. only when it meets a non-NULL value (AKA)

STRING ENDS WITH 10 SINCE 10 = NULL

CURRENT VERSION DOES NOT WORK FOR NUMBERS ABOVE 7FFFFFFF

VALIDITY CHECK CODE
if(curDigit > NULL)
	if(curDigit > 47) //is at least 0
	{
		if(58 > curDigit) //is at most 9
		{
			invalFlag = False
		}
		else
		{
			if(curDigit > 64) //is at least A
			{
				if(71 > curDigit)//at most F
				{
					invalFlag = False
				}
				if(curDigit > 97) least a
				{
					if(102 > curDigit)//at most f
					{
						invalFlag = False
					}
					else
					{
						invalFlag = True
					}
				}
				else
				{
					invalFlag = True
				}
			}
			else
			{
				invalFlag = True
			}
		}
	}
	else
	{
		invalFlag = True
	}
	
AddDecimalToSum:
	exponent = digitCount - 1
	while(digitCount > 0)
	{
		expCounter = 0
		multiplier = 1
		while(expCounter != exponent)
		{
			multiplier *= 16
			expCounter++
		}
		sum = digit * multiplier
		cumulativeSum += sum
		//shift digit focus right
		exponent -= 1
		digitCount -= 1
	}
----------------------------------------
CalcuateDecimal:
	add $t0, $a0, $zero #sets digit address to leftmost slot
	li $t2, 0 #initializes digit counter to zero
	
	totalDigitsLoop:
		lb $t1, 0($t0) #loads new digit 
		beq $t1, $s0, AddDecimalToSum #If the value is null
		beq $t2, $s1, AddDecimalToSum #If counter = max string size
		addi $t0, $t0, 1 #shifts attention to next digit
		addi $t2, $t2, 1 #increment digit counter
		
		j totalDigitsLoop
	AddDecimalToSum:
		li $t7, 0 #cumulativeSum = 0
		add $t5, $t2, $zero #records max exponent
		sub $t0, $t0, $t5 #shifts attention to first digit address
		decimalToSumLoop:
			li $t3, 0 #expCounter = 0
			li $t4, 1 #multiplier = 1
			addi $t5, $t5, -1 #exponent = exponent - 1 for each digit down the line
			addi $t2, $t2, -1 #add 1 to the digit count
			multiplierLoop:
				beq $t3, $t5, multiplierLoopEnd #end when 16 is raised to the <exponent>
				mult $t4, $s2 #raise 16 by 1 power
				mflo $t4 #load result of previous multiplication
				addi $t3, $t3, 1 #increment expCounter
				
				add $a0, $t4, $zero #Set output source to 
				li $v0, 1 #Output Integer code loaded
				syscall	#Output integer
				
				j multiplierLoop #repeat loop
			multiplierLoopEnd:
				lb $t1, 0($t0) #loads new digit
				mult $t4, $t1 #multiplier * curDigit
				mflo $t6 #load result of previous multiplication
				add $t7, $t7, $t6 #adds digit decimal value to cumulativeSum
				addi $t5, $t5, -1 #lowers exponent because next digit is of 1 less power
				addi $t0, $t0, 1 #shifts attention to next digit
				
				
				
				bne $t2, $zero, decimalToSumLoop #repeat while at least 1 digit remains
		decimalToSumLoopEnd:
			add $v0, $t7, $zero
			jr $ra #end of function
