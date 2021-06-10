;input 0-11/output month corresponding

.ORIG x3000	
RESTART	LEA R0, PROMPT		;LOADS PROMPT MESSAGE
	PUTS			;WHOS MESSAGE ON CONSOLE
	GETC			;READS IN FIRST
	ADD R3, R0, X0		;COPY R0 TO R3
	GETC			;READS IN SECOND
	ADD R4, R0, X0		;COPY R0 TO R3
	AND R7, R7, X0
;GET 2 INPUTS IN #0 FORM
	ADD R3, R3, #-16	;Offset by 16 for ascii
	ADD R3, R3, #-16	;OFFSET BY 16, TOTAL 32
	ADD R3, R3, #-16	;OFFSET BY 16, TOTAL 48

	ADD R4, R4, #-16	;Offset by 16 for ascii
	ADD R4, R4, #-16	;OFFSET BY 16, TOTAL 32
	ADD R4, R4, #-16	;OFFSET BY 16, TOTAL 48

	BRn	NOSECD		;second digit was not a number
	ADD R5, R4, #-9		;
	BRp	ERROR		;INCORRECT INPUT

	AND R5, R5, #0		;CLEAR R5
	ADD R5, R3, X0		;
	BRn	ERROR		;Throws error of not correct input

	ADD R5, R5, #-9		;CHECKS IF NUMBER
	BRp	ERROR		;Throws error of not correct input
	AND R5, R5, #0		;CLEAR R5

	ADD R5, R3, X0		;
	ADD R5, R5, #-1		;CHECKS IF TENS IS >1
	BRp 	ERROR		;IF >1 THROW ERROR
	BRz	TEN
	BRn	ONES

ONES	LEA R0, MONTH
	ADD R7, R7, R4
	BR 	LOOP



TEN 	ADD R7, R7, XA
	BR	ONES


;ZERO BRANCHING 
;	LEA R0, MONTH		;LOADS MONTH TO R0
;	ADD R7, R7, X0 		;ZERO BRANCHING
;	BR LOOP			;

NOSECD	
	ADD R5, R3, X0		;
	BRn	ERROR		;Throws error of not correct input
	ADD R5, R5, #-9		; CHECKS IF NUMBER
	BRp	ERROR		;Throws error of not correct input
	LEA R0, MONTH		;LOADS MONTH TO R0
	AND R7, R7, X0
	ADD R7, R7, R3 		;SET INDEX
	ADD R7, R7, X0		;
LOOP	
	BRz DISPLAY		;LOOP LABLE, IF 0, GO TO DISPLAY
	ADD R0, R0, #10		;FILL REGISTER WITH MAX CHARACTERS
	ADD R7, R7, #-1		;REDUCES BY ONE, GOING TO NEXT MONTH
	BR LOOP			;GO TO LOOP

DISPLAY 
	PUTS			;SHOW ON SCREEN
	LEA R0, LF		;LOAD LF, HOLDS MONTH AS STRING
	PUTS			;SHOW ON SCREEN
	BR RESTART		;GO BACK TO PROMPT


ERROR	
	LEA R0, ERMS		;LOADS ERROR MESSAGE FOR INVALID INPUT
	PUTS			;DISPLAYS MESSAGE3
	HALT			;STOPS PROGRAM

;DATA

PROMPT	.STRINGZ	"PLEASE ENTER NUMBER '00' - '11': " ;USER PROMPT
MONTH	.STRINGZ	"JANUARY  " ;LIMIT IS 10, 9 CHAR PLUS 1 NULL
	.STRINGZ	"FEBRUARY "
	.STRINGZ	"MARCH    "
	.STRINGZ	"APRIL    "
	.STRINGZ	"MAY      "
	.STRINGZ	"JUNE     "
	.STRINGZ	"JULY     "
	.STRINGZ	"AUGUST   "
	.STRINGZ	"SEPTEMBER"
	.STRINGZ	"OCTOBER  "
	.STRINGZ	"NOVEMBER "
	.STRINGZ	"DECEMBER " 
ERMS	.STRINGZ	"INVALID INPUT"	;TERMINATION MESSAGE
LF	.FILL X000A

.END