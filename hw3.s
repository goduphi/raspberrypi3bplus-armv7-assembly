.global sumS32
.global sumU32_64
.global leftStringFull
.global countNegative
.global leftStringTrunc
.global countMatches
.global find2ndMatch
.global sortDecendingInPlace
.global decimalStringToInt8
.global hexStringToUint32
.global uint8ToBinaryString
.global findStreet

.text

sumS32:
	MOV R3, #0
	CMP R0, #0
	BEQ ADD_ELEMENTS_END
add_loop_start:
	LDR R2, [R0], #4
	ADD R3, R3, R2
	SUBS R1, R1, #1
	BEQ ADD_ELEMENTS_END
	B add_loop_start
ADD_ELEMENTS_END:
	MOV R0, R3
	BX LR
	
sumU32_64:
	PUSH {R4}
	MOV R2, R0
    MOV R0, #0
	MOV R4, R1
	MOV R1, #0
sumU32_64_loop:
    CMP R4, #0
    BEQ sumU32_64_end
    LDR R3, [R2], #4
    ADDS R0, R0, R3
	ADC R1, R1, #0 /* since it is a 64 bit number, we need to add with carry */
    SUB R4, R4, #1
    B sumU32_64_loop   
sumU32_64_end:
	POP {R4}
    BX LR
	
countNegative:
	MOV R3, #0
	CMP R0, #0
	BEQ END_CNT_NEG
CNT_NEG_LOOP_START:
	LDR R2, [R0], #4
	CMP R2, #0
	ADDMI R3, R3, #1
	SUBS R1, R1, #1
	BEQ END_CNT_NEG
	B CNT_NEG_LOOP_START
END_CNT_NEG:
	MOV R0, R3
	BX LR

leftStringFull:
/* This part of the program is used find the length of the inputted string */
	PUSH {R4}
	PUSH {R5}
	MOV R4, R1
leftStringFull_count_chars:
	LDRB R3, [R4], #1
	CMP R3, #0
	BEQ leftStringFull_length_check
	ADD R5, R5, #1
	B leftStringFull_count_chars
leftStringFull_length_check:
/* If the length of the string is less than the count, exit */
	CMP R5, R2
	BMI leftStringFull_end
leftStringFull_loop_start:
	LDRB R3, [R1], #1
	STRB R3, [R0], #1
	SUBS R2, R2, #1
	BEQ leftStringFull_end_2
	B leftStringFull_loop_start
leftStringFull_end:
	MOV R3, #0
	STRB R3, [R0]
	POP {R4, R5}
	BX LR
leftStringFull_end_2:
	MOV R3, #0
	STRB R3, [R0]
	BX LR
	
leftStringTrunc:
	CMP R1, #0
	BEQ leftStringTrunc_end
leftStringTrunc_loop:
	LDRB R3, [R1], #1
	STRB R3, [R0], #1
	CMP R3, #0
	BEQ leftStringTrunc_break
	SUBS R2, R2, #1
	BEQ leftStringTrunc_end
	B leftStringTrunc_loop
leftStringTrunc_end:
	MOV R3, #0
	STRB R3, [R0]
	BX LR
leftStringTrunc_break:
	BX LR

/* hello inside of hello world */
countMatches:
	PUSH {R4, R5}
	CMP R0, #0
	BEQ END_OF_STRING
countMatches_prog_start:	
	/* let us use R2 are our counter for the number of matches */
	/* initialize R2 to 0 */
	MOV R2, #0
	MOV R5, R1 /* I do not want R1 changing, so I move it to R5 */
	/* extract first character of strMatch */
COUNT_MATCH_LOOP_START:
	LDRB R3, [R5], #1 /* post increment R1 by 1 hEllo */
FIND_CHAR:
	LDRB R4, [R0], #1 /* post increment R0 by 1 hEllo*/
	CMP R4, #0
	BEQ END_OF_STRING
	CMP R3, R4
	BEQ FOUND_CHAR
	B FIND_CHAR
FOUND_CHAR:
	CMP R3, #0
	BEQ STRING_FOUND
	CMP R3, R4
	BEQ KEEP_SEARCHING_FOR_CHAR
	BNE STRING_NOT_FOUND
KEEP_SEARCHING_FOR_CHAR:
	LDRB R3, [R5], #1 /* strMatch incrementing */
	CMP R3, #0
	BEQ STRING_FOUND
	LDRB R4, [R0], #1 /* strIn incrementing */
	CMP R4, #0
	BEQ END_OF_STRING
	B FOUND_CHAR
STRING_FOUND:
	ADD R2, R2, #1
	MOV R5, R1
	B COUNT_MATCH_LOOP_START
STRING_NOT_FOUND:
	MOV R0, #0
	POP {R4, R5}
	BX LR
END_OF_STRING:
	MOV R0, R2
	POP {R4, R5}
	BX LR

find2ndMatch:
	PUSH {R4, R5, R6, R7}
	MOV R6, #0
	MOV R2, #0
	MOV R5, R1
	MOV R7, #0
	CMP R1, #0
	BEQ SCND_STRING_NOT_FOUND
	CMP R0, #0
	BEQ SCND_STRING_NOT_FOUND
COUNT_LENGTH:
	LDRB R3, [R5], #1
	CMP R3, #0
	BEQ SCND_COUNT_MATCH_LOOP_START
	ADD R7, R7, #1
	B COUNT_LENGTH
SCND_COUNT_MATCH_LOOP_START:
	MOV R5, R1
	CMP R6, #2
	BEQ SCND_END_OF_STRING
	LDRB R3, [R5], #1 /* post increment R1 by 1 hEllo */
SCND_FIND_CHAR:
	LDRB R4, [R0], #1 /* post increment R0 by 1 hEllo*/
	CMP R4, #0
	BEQ SCND_END_OF_STRING
	ADD R2, R2, #1
	CMP R3, R4
	BEQ SCND_FOUND_CHAR
	B SCND_FIND_CHAR
SCND_FOUND_CHAR:
	CMP R3, R4
	BEQ SCND_KEEP_SEARCHING_FOR_CHAR
	BNE SCND_STRING_NOT_FOUND
SCND_KEEP_SEARCHING_FOR_CHAR:
	LDRB R3, [R5], #1 /* strMatch incrementing */
	CMP R3, #0
	BEQ SCND_STRING_FOUND
	LDRB R4, [R0], #1 /* strIn incrementing */
	CMP R4, #0
	BEQ SCND_END_OF_STRING
	ADD R2, R2, #1
	B SCND_FOUND_CHAR
SCND_STRING_FOUND:
	ADD R6, R6, #1
	B SCND_COUNT_MATCH_LOOP_START
SCND_STRING_NOT_FOUND:
	MOV R0, #-1
	POP {R4, R5, R6}
	BX LR
SCND_END_OF_STRING:
	CMP R6, #1
	BEQ SCND_STRING_NOT_FOUND
	SUB R2, R2, R7
	MOV R0, R2
	POP {R4, R5, R6, R7}
	BX LR

sortDecendingInPlace:
	PUSH {R4, R5, R6}
SORT_MAIN_LOOP:
	MOV R4, R0
	MOV R2, #0
	MOV R6, R1
	LDR R3, [R0]	
SORT_LOOP_START:
	SUBS R6, R6, #1
	CMP R6, #0
	BEQ INCREMENT_REGISTER
	ADD R2, R2, #4
	ADD R4, R4, #4
	LDR R5, [R4] /* 5 2 7 9 */
	CMP R3, R5
	BMI SWAP_DATA
	B SORT_LOOP_START
SWAP_DATA:
	STR R5, [R0]
	ADD R0, R0, R2
	STR R3, [R0]
	SUB R0, R0, R2
	MOV R3, R5
	B SORT_LOOP_START
INCREMENT_REGISTER:
	ADD R0, R0, #4
	SUBS R1, R1, #1
	CMP R1, #0
	BEQ sortDecendingInPlace_end
	B SORT_MAIN_LOOP
sortDecendingInPlace_end:
	POP {R4, R5, R6}
	BX LR

decimalStringToInt8:
	PUSH {R4, R5}
	MOV R5, #10
	MOV R2, #1 /* sign number */
	MOV R4, R0
	MOV R0, #0
convert_loop_start:
	LDRSB R1, [R4], #1
	CMP R1, #45
	BEQ SET_SIGN
	CMP R1, #0
	BEQ convert_loop_end
	SUBS R1, R1, #48
	CMP R1, #9
	BPL invalid_digit
	MUL R0, R0, R5
	ADD R0, R0, R1
	B convert_loop_start
invalid_digit:
	MOV R0, #0
	POP {R4, R5}
	BX LR
SET_SIGN:
	MOV R2, #-1
	B convert_loop_start
convert_loop_end:
	MUL R0, R0, R2
	POP {R4, R5}
	BX LR

hexStringToUint32:
	PUSH {R4,R5,R6,R7}
	MOV R1, R0
	MOV R3, #16
	MOV R0, #0
	MOV R4, #0
	MOV R5, #15
hex_convert_loop_start:
	MOV R6, #70
	MOV R7, #15
	LDRSB R2, [R1], #1
	CMP R2, #0
	BEQ hex_loop_end
	CMP R2, #65
	PUSH {LR}
	BLPL A_F
	POP {LR}
	SUBMI R2, R2, #48
	CMPMI R5, R2
	MOVMI R0, #0
	BMI hex_loop_end
	MULS R4, R0, R3
	ADD R0, R4, R2
	B hex_convert_loop_start
A_F:
	CMP R6, R2
	MOVMI R2, #0
	BMI hex_loop_end
	MOVEQ R2, R7
	BXEQ LR
	SUB R6, R6, #1
	SUB R7, R7, #1
	B A_F
hex_loop_end:
	POP {R4,R5,R6,R7}
	BX LR

uint8ToBinaryString:
    MOV R2, #0x00000080 /* mask where only bit 7 set */ 
utob_loop:
    TST R1, R2
    MOVNE R3, #'1'       
    MOVEQ R3, #'0'
    STRB R3, [R0], #1
    MOVS R2, R2, LSR #1
    BNE utob_loop
    MOV R3, #0
    STRB R3, [R0]       
    BX LR
	
findStreet:
	PUSH {R4, R5, R6, R7}
	CMP R0, #0
	BEQ EXIT_LOOP
	CMP R1, #0
	BEQ EXIT_LOOP
	CMP R2, #0
	BEQ EXIT_LOOP
	MOV R7, #0
	ADD R1, R1, #0x1F /* go to the street member */
MAIN_LOOP:
	MOV R4, R0 /* name of street */
	MOV R6, R1
CONTINUE:	
	LDRB R5, [R4], #1
	LDRB R3, [R6], #1
	CMP R3, #0
	BEQ STREET_FOUND
	CMP R5, R3
	BEQ CONTINUE
	BNE NOT_FOUND
NOT_FOUND:
	SUB R2, R2, #1 /* decrement count to say that I finished with one struct */
	CMP R2, #0
	BEQ EXIT_LOOP
	ADD R7, R7, #1 /* I moved to the next struct */
	ADD R1, R1, #0x78 /* move to the next struct street member since it is 120 bytes = 0x78 */
	B MAIN_LOOP
STREET_FOUND:
	MOV R0, R7
	POP {R4, R5, R6, R7}
	BX LR
EXIT_LOOP:
	MOV R0, #-1
	POP {R4, R5, R6, R7}
	BX LR
	