;D + C > 10
;C = 10
;Illustrate the use branching.


.ORIG X3000

AND R1, R1, X0
LDI R1, D
AND R2, R2, X0
LDI R2, C

;10 FOR STORAGE
AND R3, R3, X0
ADD R3, R3, XA
NOT R3, R3	;1'S COMP
ADD R3, R3, X1	;2'S

;CHECK C>= 10
AND R4, R4, X0
ADD R4, R2, R3 	; C - 10
STI R4, CRES


;CHECK C+D > 10

AND R5, R5, X0
ADD R5, R1, R2	; C + D
ADD R5, R5, R3	; C + D -10
BRp	POS
BRn	NEG
BRz	ZER

POS 
AND R6, R6, X0
ADD R6, R6, X1	;SHOW 1 IF POS
STI R6, RES	;STORE RESULT
HALT

ZER
AND R6, R6, X0	;SHOW 0 IF D = 0
STI R6, RES 	;STORE RESULT
HALT


NEG
AND R6, R6, X0
ADD R6, R6, X2	;SHOW 2 IF NEG
STI R6, RES
HALT


;DATA

D	.FILL x3200
C	.FILL x3201
RES	.FILL x3202
CRES	.FILL x3203

.END