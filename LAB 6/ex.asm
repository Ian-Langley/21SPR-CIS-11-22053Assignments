;Lab 6
;F(n) = f(n-2) + F(n-1)
	.ORIG X3000
	LDI R1, n
	AND R2, R2, #0	;CLEARS R2
	ADD R2, R2, #1	;SEED R2 
	ADD R2, R2, #-3	;R2 = #-2
	ADD R2, R2, R1	;CHECKS FOR POS
	BRp POS
	AND R4, R4, #0	;CLEARS R4
	ADD R4, R4, #1	; F = 1 IF NEG
	STI R2, Fn	;STORE RESULT TO R2
	BR skip
POS	AND R2, R2, #0	; CLEARS R2
	ADD R2, R2, #1	; R2=1 , a=1
	AND R3, R3, #0	; INITIALIZES R3
	ADD R3, R3, #1	; R3 = 1, B=1
	ADD R5, R1, #-2	; N-2
FAB	ADD R4, R2, R3	; F = B + A
	ADD R2, R3, #0	; A = B
	ADD R3, R4, #0	; B = F
	ADD R5, R5, #-1	; N-1
	BRp FAB		; LOOPS AGAIN IF STILL +s
	AND R2, R2, #0	; CLEAR R2
	ADD R2, R2, #1	; R2 = 1, A
	AND R3, R3, #0	; CLEAR R3
	ADD R3, R3, #1	; R3 = 1, B
	AND R5, R5, #0	; CLEAR R5
	ADD R4, R4, #2	; R5 = 2
FAB2	ADD R4, R2, R3	; F = B + A
	BRn NEG		
	ADD R2, R3, #0	; A = B
	ADD R3, R4, #0	; B = F
	ADD R4, R4, #1	; I = I +1
	BRp FAB2
NEG	AND R6, R6, #0	; CLEAR R6
	ADD R6, R5, #0	; N = I
	STI R6, N	; STORE R6 IN N
	STI R3, FN	; STORE R3 RESULT IN FN
skip
	HALT
n	.FILL X3100
Fn	.FILL X3101
N	.FILL X3102
FN	.FILL X3103
	.END