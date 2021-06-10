.ORIG x3000

LDI R1, X	; load x into r1
LDI R2, Y	; load y into r2
NOT R4, R2	; negate r2 into r4
ADD R4, R4, #1	; add 1 to r4
ADD R3, R1, R4	; add r1 and r4 to r3
STI R3, XMY 	; store r3 to xmy
ADD R4, R1, #0	; add 0 to r1 into r4
BRzp ZPX	; if zero/+ go to zpx
NOT R4, R4	; negate r4 into r4
ADD R4, R4, #1	; add 1 to r4

ZPX		;lable 
STI R4, ABSX	; store r4 into absx
ADD R5, R2, #0	; add d0 to r2 into r5
BRzp ZPY	; if 0/+ go to zpy
NOT R5, R5	; negate r5 into r5
ADD R5, R5, #1	; add +1 to r5

ZPY		;lable
STI R5, ABSY	; store r5 into ABSY
NOT R7, R5	; negate r5 into r7
ADD R7, R7, #1	; add 1 to r7
ADD R6, R5, R7	; add r5 and r7 into r6
BRp POS		;
BRz ZERO	;
BRn NEG		;

POS		;lable
AND R6, R6, x0	; clear r6 register
ADD R6, R6, #1	; add 1 to r6
STI R6, Z	; store r6 to z
HALT

ZERO		;lable
AND R6, R6, X0	; clear r6 register
STI R6,  Z	; store r6 to z
HALT		

NEG		;lable
AND R6, R6, X0	; clear r6 register
ADD R6, R6, #2	; add 2 to r6 into r6
STI R6, Z	; store r6 to z
HALT


;SETTING VARIABLE LOCATION
X	.FILL X3120
Y	.FILL X3121
XMY	.FILL X3122
ABSX	.FILL X3123
ABSY	.FILL X3124
Z	.FILL X3125

.END