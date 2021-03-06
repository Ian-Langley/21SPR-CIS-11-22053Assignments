		.ORIG x3000 
		LDI R1, X 
		ADD R1, R1, #-2 
		BRp NOTJANFEB 
		ADD R1, R1, #12			;get M if month is january or feb 
		LDI R0, C 
		ADD R0, R0, #-1 
		STI R0, C 			; use previous year if month is jan or feb 

NOTJANFEB 
		STI R1, M 
		AND R0, R0, x0 
		ADD R0, R0, #13 		; multiply m by 13 
		JSR MULT 
		ADD R2, R2, #-1 
		STI R2, NEWM 			; NEWM = (13m - 1) 
		ADD R0, R2, x0 
		AND R1, R1, x0 
		ADD R1, R1, x5 
		JSR DIV STI R2, QUOTOFM 	; QUOTOFM = (13m - 1)/5 
		LDI R0, C 
		AND R1, R1, x0 	
		ADD R1, R1, xF 
		ADD R1, R1, xF 	
		ADD R1, R1, xF 
		ADD R1, R1, xF 
		ADD R1, R1, xF 
		ADD R1, R1, xF 
		ADD R1, R1, xA 			; R1 = #100 
		JSR DIV 			; divide RO by 100 to get the year 
		STI R0, D 			; R0 should now have remainder, aka last 2 digits 
		STI R2, NEWC 			; R2 should now be equal to first 2 digits 
		LDI R0, D 
		AND R1, R1, x0 
		ADD R1, R1, x4 
		JSR DIV 
		STI R2, QUOTOFD 		; QUOTOFD = D/4 
		LDI R0, NEWC 
		AND R1, R1, x0 
		ADD R1, R1, x4 
		JSR DIV 
		STI R2, QUOTOFC 		; QUOTOFC = C/4 
		JSR ZELLERS			; add up what we have up to now 
		STI R0, F 
		AND R1, R1, x0 
		ADD R1, R1, x7 
		JSR DIV 			; get mod 7 of result 
		STI R0, MODF 
		ADD R1, R0, x0 			; copy R0 (the remainder) to R1 
		LEA R0, DAYS 			; load address of DAYS 
LOOP 						; loop until correct day is loaded 
		ADD R1, R1, #-1 		; R1 holds remainder; decrement it until negative 
		BRn DISPLAY 
		ADD R0, R0, xA 			; add 10 to address of day to print 
		BR LOOP 
		DISPLAY PUTS 
		HALT 

MULT 						; R0 and R1 will have params, result will be in R2 
		ADD R0, R0, x0 
		BRnz END 			; Go to end of program if any are negative or zero 
		ADD R1, R1, x0 
		BRnz END 
		AND R2, R2, x0 			; clear R2 
MULTLOOP 
		ADD R2, R2, R0 
		ADD R1, R1, #-1 
		BRp MULTLOOP 
		BRn END 
		RET 
DIV 						; R0 is dividend, R1 is divisor, store result in R2, remainder in R0 
		ADD R0, R0, x0 
		BRn END 			; Go to end of program if either parameter is negative or divisor is 0 
		ADD R1, R1, x0 
		BRnz END 
		NOT R1, R1 
		ADD R1, R1, x1 			; 2's complement 
		AND R2, R2, x0 			; clear R2 

DIVLOOP 					; subtract R1 from RB until R0 is 0 or negative 
		ADD R0, R0, R1 
		BRn DIVEND 
		BRz DIVENDNOR 			; we use this if there is no remainder 
		ADD R2, R2, x1 			; add one to result 
		BR DIVLOOP 	
DIVENDNOR 	
		ADD R2, R2, x1			; make sure to add final number to result 
		ADD R0, R0, R1 			; this will make the remainder 0 after R1 is added 

DIVEND 		
		NOT R1, R1 
		ADD R1, R1, x1 			; 2's complement, R1 is positiue again 
		ADD R0, R0, R1 ;		 this makes the remainder valid 
		RET 
ZELLERS 					; performs the operation RO = k + (13m * 1)/5 + D + D/4 +C/4 - 2C 
		LDI R0, K 
		LDI R1, QUOTOFM 
		ADD R0, R0, R1 
		LDI R1, D 
		ADD R0, R0, R1 
		LDI R1, QUOTOFD 
		ADD R0, R0, R1 
		LDI R1, QUOTOFC 
		ADD R0, R0, R1 
		LDI R1, NEWC 
		ADD R1, R1, R1 			; double to get 2C 
		NOT R1, R1 
		ADD R1, R1, x1 			; make 2C negatiue 
		ADD R0, R0, R1 
		RET
 
		END HALT 			; end program 

; DATA 
DAYS 		.STRINGZ "Sunday   " 		; outputs certain day, MUST BE ALIGNED 
		.STRINGZ "Monday   " 
		.STRINGZ "Tuesday  "
		.STRINGZ "Wednesday" 
		.STRINGZ "Thursday " 
		.STRINGZ "Friday   " 
		.STRINGZ "Saturday " 
X		.FILL X31F0
K		.FILL X31F1
C		.FILL X31F2
D		.FILL X31F3
R		.FILL X31F4
M		.FILL X31F5
NEWM		.FILL X31F6
QUOTOFM		.FILL X3103
QUOTOFD		.FILL X3104
QUOTOFC		.FILL X3105
F		.FILL X3106
MODF		.FILL X3107
NEWC		.FILL X3108
.END


