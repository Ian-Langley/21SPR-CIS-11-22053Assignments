;LAB 8: FASTER MULT.

		.ORIG X300
		JSR MULT1
		HALT
; SAVE REGISTERS TO REP BINARY

MULT1		ST R0, SAVEREG0		;R0 = X, STORE X SAVEREG LOC
		ST R1, SAVEREG1		;R1 = Y, STORE Y SAVEREG LOC
		ST R2, SAVEREG2
		ST R3, SAVEREG3
		ST R4, SAVEREG4
		ST R5, SAVEREG5
		ST R6, SAVEREG6
		ST R7, SAVEREG7

		AND R7, R7, #0		;CLEARS REGISTER 7
		ADD R7, R7, #1		;SIGN BIT
		LDI R0, X		;LOADS X TO R0
		ADD R0, R0, #0		;INTIALIZE R0 = 0
		BRzp POS		;BRANCH IF POS
		ADD R7, R7, #-1		;SUBT. 1 TO TEST FOR SIGN
		NOT R0, R0		;1'S COMP
		ADD R0, R0, #1		;2'S COMP

POS		LDI R1, Y		;LOAD Y TO R1
		ADD R1, R1, #0		;INTIALIZE R1 TO 0
		BRzp POS2		;BRANCH TO POS 2 IF POS, THIS IS A NESTED CONDITION
		ADD R7, R7 #-1		;SUBT. 1 TO TEST FOR SIGN
		NOT R1, R1		;1'S COMP
		ADD R1, R1, #1		;2'S COMP

POS2		AND R2, R2, #0		;CLEAR R2
		AND R4, R4, #0		;CLEAR R4
		AND R5, R4, #0		;CLEAR R5
		ADD R4, R4, #15		;R4 = #15, COUNT IN FOR LOOP
		ADD R2, R2, X1		;R2 = X1, ADD 1 FOR SHIFT
		ADD R6, R1, #0		; COPY R1 TO R6 WHICH NOW = Y

LOOP		AND R3, R6, R2		;LEAST SIG BIT = R4
		BRz ISZERO		;BRANCH IF ZERO(0)
		ADD R5, R5, R0		;R5 = X

ISZERO	 	ADD R2, R2, R2		;SHIFT 1 TO LEFT BIT
		ADD R0, R0, R0		;SHIFT VALUE IS X
		ADD R4, R4, #-1		;SUBTRACT 1 FROM R4, CONDITON(COUNTER)
		BRp LOOP		;IF POS GO TO LOOP
		ADD R7, R7, #0		;SECONDARY COJNDITION
		BRnp NOTZERO		;GO TO NOTZERO IF POS/NEG
		NOT R5, R5		;1'S CMOP
		ADD R5, R5, #1		;2'S COMP

NOTZERO		STI R5, P		;STORE R5 TO P
		LD R0, SAVEREG0		;LOAD SAVED VALUE TO REGISTER
		LD R1, SAVEREG1
		LD R2, SAVEREG2
		LD R3, SAVEREG3
		LD R4, SAVEREG4
		LD R5, SAVEREG5
		LD R6, SAVEREG6
		LD R7, SAVEREG7
		RET			;RETURN FROM SUBROUTINE

SAVEREG0	.FILL X0
SAVEREG1	.FILL X1
SAVEREG2	.FILL X2
SAVEREG3	.FILL X3
SAVEREG4	.FILL X4
SAVEREG5	.FILL X5
SAVEREG6	.FILL X6
SAVEREG7	.FILL X7
X		.FILL X3100		;X
Y		.FILL X3101		;Y
P		.FILL X3102		;PRODUCT RESULT
		.END