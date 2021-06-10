.ORIG x3000

	LD R3, COUNTER		; load COUNTER for our LOOP
	LD R6, BASE		; load the address of our stack (pointer)
	LEA R0, MSG0		; load address of MGS0 into R0
	ADD R4, R0, x0		; copy address into R4
LOOP	ADD R0, R4, x0
	PUTS			; ask user for test score
	IN			; retrieve 1st digit of text score from user
	ADD R1, R0, x0		; move user input (1st digit) into R1
	IN			; retrieve 2nd digit of text score from user
	ADD R2, R0, x0		; move user input (2nd digit) into R2	
	JSR CONVERT		; CONVERT SUBROUTINE
	JSR PUSH		; PUSH SUBROUTINE
	ADD R4, R4, #7		; loop through our MSG0 strings
	ADD R3, R3, #-1		; decrement loop counter
	BRp LOOP		; if counter is pos, LOOP again

	LDI R1, T1D1		; load 1st digit of 1st test into R1
	LDI R2, T1D2		; load 2nd digit of 2nd test into R2
	STI R1, MinD1		; store R1 into MinD1
	STI R1, MaxD1		; store R1 into MaxD1
	STI R2, MinD2		; store R2 into MinD2
	STI R2, MaxD2		; store R2 into MaxD2		
	
	LD R6, T2D1		; setting up pointer for MIN subroutine
	LD R3, COUNTER		; setting up counter for looping
	JSR MIN			; MIN subroutine
	LD R6, T2D1		; setting up pointer for MAX subroutine
	LD R3, COUNTER		; setting up counter for looping
	JSR MAX			; MAX subroutine
	LD R6, T1D1		; setting up pointer for AVG subroutine
	LD R3, COUNTER		; setting up counter for looping
	JSR AVG			; AVG subroutine

	LD R6, T1D1		; (pointer)
	LEA R0, MSG3		; test scores summarized
	PUTS
	LD R3, COUNTER		; loop variable
UNSTACK	LD R0, NEWLINE		; for blank line
	PUTC
	JSR POP			; pop the stack (1st digit)
	ADD R1, R0, x0		; copy 1st digit into R1, for the LGRADE subroutine
	JSR REVERT		; convert 1st digit (in R0) back to ASCII for console output
	OUT			; output to the console
	JSR POP			; POP the stack again (2nd digit)
	JSR REVERT		; convert 2nd digit back to ASCII for console output
	OUT			; output to the console
	JSR LGRADE		; LGRADE subroutine for letter grade
	PUTS			; output letter grade to console
	ADD R3, R3, #-1		; decrement loop variable
	BRp UNSTACK		; if counter is pos, loop to UNSTACK
	BR EXIT			; else, go to EXIT
EXIT	LD R0 NEWLINE		; blank line
	PUTC
	LEA R0, MSG1		; for min
	PUTS
	JSR POP			; POP subroutine
	JSR REVERT		; REVERT subroutine
	OUT			; output to console
	JSR POP			; POP subroutine
	JSR REVERT		; REVERT subroutine
	OUT			; output to console
	LD R0, NEWLINE		; blank line
	PUTC
	LEA R0, MSG2		; for max
	PUTS			
	JSR POP			; POP subroutine
	JSR REVERT		; REVERT subroutine
	OUT			; output to console
	JSR POP			; POP subroutine
	JSR REVERT		; REVERT subroutine
	OUT			; output to console
	LD R0, NEWLINE		; blank line
	PUTC	
	LEA R0, MSG4		; for avg
	PUTS
	JSR POP			; POP subroutine
	JSR REVERT		; REVERT subroutine
	OUT			; output to console
	JSR POP			; POP subroutine
	JSR REVERT		; REVERT subroutine
	OUT			; output to console
	
	
END	HALT			; end program


;DATA
NEWLINE .FILL x0A       	; A decimal 10, or a hex 'A' for new line
COUNTER	.FILL x5		; loop counter
MSG0	.STRINGZ "Test1:"
	.STRINGZ "Test2:"
	.STRINGZ "Test3:"
	.STRINGZ "Test4:"
	.STRINGZ "Test5:"
MSG1	.STRINGZ "The minimum test score is "
MSG2	.STRINGZ "The maximum test score is "
MSG3	.STRINGZ "Test scores: "
MSG4	.STRINGZ "The average test score is "


BASE    .FILL x4110
T1D1    .FILL x410F
T1D2    .FILL x410E
T2D1    .FILL x410D
T2D2    .FILL x410C
T3D1    .FILL x410B
T3D2    .FILL x410A
T4D1    .FILL x4109
T4D2    .FILL x4108
T5D1    .FILL x4107
T5D2    .FILL x4106
MinD1    .FILL x4105
MinD2    .FILL x4104
MaxD1    .FILL x4103
MaxD2    .FILL x4102
AvgD1    .FILL x4101
AvgD2    .FILL X4100
AVGR7	.FILL X4112

GRADE	.STRINGZ "-F"
	.STRINGZ "-D"
	.STRINGZ "-C"
	.STRINGZ "-B"
	.STRINGZ "-A"


LGRADE				; LGRADE SUBROUTINE
	LEA R0, GRADE
	ADD R1, R1, #-5		; setting up our decrement variable	
GLOOP	BRnz DISPLAY		; if decrement loop variable is neg/zero go to DISPLAY
	ADD R0, R0, #3		; iterate to the next letter grade
	ADD R1, R1, #-1		; decrement loop variable
	BR GLOOP
DISPLAY RET			; once we have the letter grade, return to program


MIN				; MIN subroutine
	LDI R1, MinD1		; load MinD1 into R1
	NOT R1, R1
	ADD R1, R1, #1		; 2s complement of R1
	LDR R2, R6, #0		; load first digit of current test into R2
	ADD R1, R2, R1
	BRp NSKIP1		; if pos, go to SKIP1
	BRn NCONT1		; if neg, go to CONT1
	ADD R6, R6, #-1		; decrement pointer of our stack
	LDI R1, MinD2		; load MinD2 into R1
	NOT R1, R1
	ADD R1, R1, #1		; 2s complement of R1
	LDR R2, R6, #0		; load 2nd digit of test into R2
	ADD R1, R2, R1
	BRzp NSKIP2		; if zero/pos, go to SKIP2
	STI R2, MinD2		; store R2 into MinD2
	BR NSKIP2		; unconditional branch to SKIP2

NCONT1	STI R2, MinD1		; store R2 into MinD1
	ADD R6, R6, #-1		; decrement pointer of our stack
	LDR R2, R6, #0		; load 2nd digit (of current test) into R2
	STI R2, MinD2		; store R2 into MinD2
	BR NSKIP2		; unconditional branch to SKIP2

NSKIP1	ADD R6, R6, #-2		; decrement our pointer by 2, to compare next test
	ADD R3, R3, #-1		; decrement loop counter
	BRp MIN			; if counter is pos, loop back to MIN
	RET

NSKIP2	ADD R6, R6, #-1		; decrement pointer 
	ADD R3, R3, #-1		; decrement loop counter
	BRp MIN			; if counter is pos, loop back to MIN
	RET

MAX				; MAX SUBROUTINE
	LDI R1, MaxD1		; load MaxD1 into R1
	NOT R1, R1
	ADD R1, R1, #1		; 2s complement of R1
	LDR R2, R6, #0		; load first digit of test into R2
	ADD R1, R2, R1
	BRn XSKIP1		; if pos, go to XSKIP1
	BRp XCONT1		; if neg, go to XCONT1
	ADD R6, R6, #-1		; decrement pointer of our stack
	LDI R1, MaxD2		; load MaxD2 into R1
	NOT R1, R1
	ADD R1, R1, #1		; 2s complement of R1
	LDR R2, R6, #0		; load 2nd digit of test into R2
	ADD R1, R2, R1
	BRnz XSKIP2		; if zero/pos, go to XSKIP2
	STI R2, MaxD2		; store R2 into MaxD2
	BR XSKIP2		; unconditional branch to XSKIP2

XCONT1	STI R2, MaxD1		; store R2 into MaxD1
	ADD R6, R6, #-1		; decrement pointer of our stack
	LDR R2, R6, #0		; load 2nd digit (of current test) into R2
	STI R2, MaxD2		; store R2 into MaxD2
	BR XSKIP2		; unconditional branch to XSKIP2

XSKIP1	ADD R6, R6, #-2		; decrement our pointer by 2, to compare next test
	ADD R3, R3, #-1		; decrement loop counter
	BRp MAX			; if counter is pos, loop back to MAX
	RET

XSKIP2	ADD R6, R6, #-1		; decrement pointer 
	ADD R3, R3, #-1		; decrement loop counter
	BRp MAX			; if counter is pos, loop back to MAX
	RET


CONVERT 			; CONVERT SUBROUTINE
	ADD R1, R1, #-16	; this will
	ADD R1, R1, #-16	; convert the user input
	ADD R1, R1, #-16	; into data we can
	ADD R2, R2, #-16	; calculate
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	RET

REVERT				; REVERT SUBROUTINE
	ADD R0, R0, #15		; this will revert
	ADD R0, R0, #15		; the data (that we converted)
	ADD R0, R0, #15		; back to ASCII,
	ADD R0, R0, #3		; so that we can print the numbers
	RET			; to the console

PUSH 				; PUSH SUBROUTINE
	ADD R6, R6, #-1		; decrement pointer
	STR R1, R6, #0		; store 1st digit in stack first
	ADD R6, R6, #-1		; decrement pointer
	STR R2, R6, #0		; store 2nd digit in stack 2nd
	RET

POP				; POP SUBROUTINE	
	LDR R0, R6, #0		; load value into R0
	ADD R6, R6, #-1		; decrement stack pointer
	RET



MULT				;R1 = BASE
	AND R5, R5, X0		;R2 = COUNTER
MULTSUB
	ADD R5, R5, R1		;R5 = RESULT
	ADD R2, R2, #-1
 	BRp MULTSUB
	RET     ;MULT SUBROUTINE

DIV				;R1 = DIVIDEND R2 = DIVISOR
	NOT R2, R2		;R5 = RESULT
	ADD R2, R2, #1
	AND R5, R5, #0
DIVSUB
	ADD R1, R1, R2
	BRn DIVEND
	ADD R5, R5, #1
	BRz DIVEND
	BRp DIVSUB
DIVEND
	RET     ;DIV SUBROUTINE

AVG	ST R7, AVGR7
	AND R0, R0, #0
AVGWRK	AND R1, R1, #0		;CLEAR R0 FOR WORK
	AND R2, R2, #0		;CLEAR R1 FOR WORK
	LDR R2,	R6, #0		;Load First Digit OF TEST TO R1
	ADD R6, R6, #-1		;DECREMENT TEST POINTER
	ADD R1, R1, #10		;READY 10 MULTIPLACTION
	JSR MULT		;Multiply by Ten
	ADD R0, R0, R5		;STORE RESULT TO TOTAL
	LDR R2, R6, #0		;Load Second Digit
	ADD R0, R0, R2		;Add TO TOTAL 
	JSR AVGCHK		;UNCONDITIONAL BRANCH TO CHECK NUMBER OF TESTS 
	
AVGCHK	ADD R6, R6, #-1		;DECREMENT POINTER
	ADD R3, R3, #-1		;DECREMENT COUNTER
	BRp AVGWRK		;BRANCH IF COUNTER NOT 0 OR -
	AND R1, R1, #0		;CLEAN WORK AREA
	AND R2, R2, #0		;CLEAN WORK AREA
	ADD R1, R0, #0		;COPY TOTAL TO R1
	ADD R2, R2, #5		;PREP R2 FOR DIV 5
	JSR DIV			;DIVIDE BY 5 FOR AVG
	AND R2, R2, #0		;CLEAR R2
	ADD R0, R5, #0		;Save Result
	ADD R1, R0, #0		;Prep Math
	ADD R2, R2, #10		;10 FOR DIV 10
	JSR DIV			;DIVIDE ONE BY TEN
	STI R5, AvgD1		;
	LDI R2, AvgD1		;STORE 10 TO AVGD1
	AND R1, R1, #10
	JSR MULT		;MULT AVGD1 BY 10
	NOT R5, R5		;SUBTRACT ROUNDED NUMBER FROM DUPLICATE
	ADD R5, R5, #1		;2'S COMP
	ADD R1, R0, R5		
	STI R1, AvgD2		;STORE SECOND DIGIT
	LD R7, AVGR7			
	RET			;AVG SUBROUTINE
.END