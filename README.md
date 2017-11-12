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
(FIND OUT WHAT SPACE LOOKS LIKE INITIALLY OR INITIALIZE SPACE SO YOU HAVE A SAFETYVALUE MAYBE ALL 00000000
