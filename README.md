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
		sum = digit * (BASE ^ exponent)
		cumulativeSum += sum
		//shift digit focus right
		exponent -= 1
		digitCount -= 1
	}
