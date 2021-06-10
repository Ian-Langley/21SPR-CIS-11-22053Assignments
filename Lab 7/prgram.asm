;Lab 7
;Multiplication, Division, and Modulus

;initiation and setup
		.ORIG X3000	
		LDI R1, X		;X IN R1
		LDI R2, Y		;Y IN R2
		JSR MULT		;MULTIPLY
		STI R3, XY		;PRODUCT IS STORED IN R4
		JSR DIV			;DIVISION
		STI R5, QUOT		;QUOTIENT IS STORED IN R5
		STI R3, R		;REMAINDER IS STORED IN R3
		HALT		

;MULTIPLACTION SUBROUTINE
MULT
		;SAVING REGISTERS
		ST R5, SaveReg5		;SAVE R5
		ST R6, SaveReg6		;SAVE R6
	
		;MATH
		ADD R5, R2, #0		;PUT Y TO R5
		NOT R4, R4		;INVERTING Y FOR 2'S
		ADD R4, R4, #1		;2'S COMPLIMENT
		BRp POSLOOP		;BRANCH FOR POS, DIFFERENT CALCS. MUST KEEP - FOR IT

LOOP	
		ADD R6, R5, R4		;CHECKS FOR N>0, YES = QUIT
		BRzp QUIT1
		ADD R5, R5, #1		;INCREASE COUNTER
		ADD R3, R3, R1		;MULTIPLY BY ONE
		BR LOOP			;LOOPS BACK, CANCLES AT QUIT CHECK IF DONE
QUIT1		RET			;TERMINATION, RETURN TO CALLING

POSLOOP
		ADD R4, R4, #0		;
LOOP2		ADD R6, R5, R4		;CHECKS FOR N>0, YES = QUIT
		BRzp QUIT2
		ADD R5, R5, #1		;INCREASE COUNTER
		ADD R3, R3, R1		;MULTIPLY BY ONE
		BR LOOP2		;LOOPS BACK, CANCLES AT QUIT CHECK IF DONE
QUIT2		NOT R3, R3		;NEGATIVE, THUS NOT ADD 1
		ADD R3, R3, #1		;

		LD R5, SaveReg5		;RESTORES R5
		LD R6, SaveReg6		;RESTORES R6
	
		RET			;RETURNS TO PROGRAM

SaveReg5	.FILL X0
SaveReg6	.FILL X0

DIV
		ADD R2, R2, #0		;CHECKS Y = 0
		BRz QUIT3		;QUITES IF Y = 0
		ADD R6, R2, #0		;MOVES Y TO R6
		AND R5, R5, #0		;CLEARS R5
		ADD R3, R1, #0		;X INTO R3
		ADD R4, R2, #0		;Y INTO R4
		NOT R4, R4		;NOT Y
		ADD R4, R4, #1		;Y 2'S COMPLIMENT
		ADD R0, R3, R4		;SUBTRACT X BY Y
		BRn QUIT2		;Y>X,
LOOP3		
		ADD R5, R5, #1		;STARTS COUNTER
		ADD R3, R3, R4		;SUBTRACT X BY Y
		BRp LOOP3		;IF POS, KEEP LOOPING
		BRZ QUIT3		;IF 0 QUIT3
		ADD R3, R3, R6		;IF NEG, ADD RESULT + Y
		ADD R5, R5, #-1		;ADD TO COUNTER
		BR QUIT3
QUIT3
		RET			;RETURN TO CALLING

X		.FILL X3100
Y		.FILL X3101
XY		.FILL X3102
QUOT		.FILL X3103
R		.FILL X3104
.END

