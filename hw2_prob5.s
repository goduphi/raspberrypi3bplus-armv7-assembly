.global add64
.global sub64
.global minU8
.global minS8
.global isLessThanU32
.global isLessThanS32
.global shiftLeftU32
.global shiftU32
.global shiftS32
.global isEqualU16
.global isEqualS16
.global strCopy
.global strConcat

.text

add64:
	ADDS R0, R0, R2 /* add LSW of x and y and store it in R0 */
	ADC R1, R1, R3 /* add MSW of x and y and store it in R1 */
	BX LR

sub64:
	SUBS R0, R0, R2 /* subtract LSW of x and y and store it in R0 */
	SBC R1, R1, R3 /* subtract MSW of x and y and store it in R1 */
	BX LR

minU8:
	CMP R0, R1 /* subtracts R1 from R0 and sets flags. Discards result */
	BMI r0_smaller /* if prev instruction result is minus (MI), branch (B) to specified location */
	MOV R0, R1 /* else move smaller number to R0 and return */
	BX LR
r0_smaller:
	BX LR
	
minS8:
	CMP R0, R1 /* 102 - 100 */
	BPL r1_larger
	BX LR
r1_larger:
	MOV R0, R1
	BX LR

isLessThanU32:
	CMP R0, R1 /* same concept as previous ones */
	BMI y_greater_than_x
	MOV R0, #0
	BX LR
y_greater_than_x:
	MOV R0, #1
	BX LR
	
isLessThanS32:
	CMP R0, R1
	BPL IF_POSITIVE
	MOV R0, #1
	BX LR
IF_POSITIVE:
	MOV R0, #0
	BX LR

isEqualU16:
	CMP R0, R1
	BEQ eql /* If Z flag set, go to eql */
	MOV R0, #0
	BX LR
eql:
	MOV R0, #1
	BX LR
	
isEqualS16:
	CMP R0, R1
	BEQ eqlS
	MOV R0, #0
	BX LR
eqlS:
	MOV R0, #1
	BX LR
	
shiftLeftU32:
    MOV R0, R0, LSL R1
    BX LR

shiftU32:
	CMP R1, #0
	BEQ RETURN_R0
	BMI RETURN_LSR
	BPL RETURN_LSL
RETURN_LSR:
	NEG R1, R1
	MOV R0, R0, LSR R1
    BX LR
RETURN_LSL:
	MOV R0, R0, LSL R1
    BX LR
RETURN_R0:
	BX LR

shiftS32:
	CMP R1, #0
	BEQ RETURN_REGISTER_R0
	BMI RETURN_ASR
	BPL RETURN_ASL
RETURN_ASR:
	NEG R1, R1
	MOV R0, R0, ASR R1
    BX LR
RETURN_ASL:
	MOV R0, R0, ASL R1
    BX LR
RETURN_REGISTER_R0:
	BX LR
	

strCopy:
STRCPY_LOOP:
	LDR R2, [R1]
	STR R2, [R0]
	CMP R2, #0 /* checks to see if result is null terminator or not */
	BEQ EXIT_LOOP
	ADD R0, R0, #1 /* increment R1 by one to move to next mem addr */
	ADD R1, R1, #1 /* increment R1 by one to move to next mem addr */
	B STRCPY_LOOP
EXIT_LOOP:
	BX LR

strConcat:
LOOP_START:
	/* logic: first loop through to find end of string */
	LDRB R2, [R0]
	CMP R2, #0 
	BEQ CONCAT_SECTION
	ADD R0, R0, #1 /* increment R0 by 1 */
	B LOOP_START
CONCAT_SECTION:
	LDR R2, [R1]
	STR R2, [R0]
	CMP R2, #0
	BEQ RETURN
	ADD R0, R0, #1
	ADD R1, R1, #1
	B CONCAT_SECTION
RETURN:
	BX LR
	
MOV R2, #0 //init x = 0
something:
	ADD R2, R2, R0
	CMP R2, R1
	ADD R0, R0, #1
	B something
	