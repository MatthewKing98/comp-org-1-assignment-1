# comp-org-1-assignment-1
MIPS Programming Assignment 1

ASSIGNMENT 1 ALGORITHM:

1. Accept input from user
2. Check if data is valid
3. If data is valid THEN
	3.1 While there is content (while STRING != 000....000)
		3.1.1 Take the rightmost character from the string
		3.1.2 Translate it to decimal
		3.1.3 Multiply it by 16^Exponent
		3.1.4 Add it to CumulativeSum
		3.1.5 Add 1 to Exponent
	3.2 Return CumulativeSum
ELSE
	Repeat 1
