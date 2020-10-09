.global sumF32
.global prodF64
.global dotpF64
.global maxF32

.text

/* R0 = &x[0], R1 = count */
sumF32:
	MOV R2, #0 /* R2 is being used a temp variable which will be used to zero out D0 */
	VMOV S0, R2
sumF32_loop_start:
	CMP R1, #0
	BEQ sumF32_loop_end
	VLDR.F32 S1, [R0]
	ADD R0, R0, #4
	VADD.F32 S0, S0, S1
	SUB R1, R1, #1
	B sumF32_loop_start
sumF32_loop_end:
	VMOV R0, S0
	BX LR

prodF64:
	/*
		*What I am doing here is moving a 1 into R2 and then
		 moving R2 into S4 and then converting the S32 into a F64
		 and storing it inside of D0
	*/
	CMP R1, #0
	BEQ insert_zero
	MOV R2, #1
	VMOV S4, R2
	VCVT.F64.U32 D0, S4
prodF64_loop_start:
	CMP R1, #0
	BEQ prodF64_loop_end
	VLDR.F64 D1, [R0] /* load 64 bit number into D1 */
	ADD R0, R0, #8
	VMUL.F64 D0, D0, D1
	SUB R1, R1, #1
	B prodF64_loop_start
prodF64_loop_end:
	VMOV R0, R1, D0
	BX LR
insert_zero:
	MOV R2, #0
	VMOV D0, R2, R2
	VMOV R0, R1, D0
	BX LR

dotpF64:
	MOV R3, #0
	VMOV D0, R3, R3
dotpF64_loop_start:
	CMP R2, #0
	BEQ dotpF64_loop_end
	VLDR.F64 D1, [R0]
	ADD R0, R0, #8
	VLDR.F64 D2, [R1]
	ADD R1, R1, #8
	VMUL.F64 D3, D1, D2
	VADD.F64 D0, D0, D3
	SUB R2, R2, #1
	B dotpF64_loop_start
dotpF64_loop_end:
	VMOV R0, R1, D0
	BX LR

maxF32:
	MOV R2, #0
	VMOV S0, R2
maxF32_loop_start:
	CMP R1, #0 /* see if count, R0 is zero or not */
	BEQ maxF32_loop_end
	VLDR.F32 S1, [R0] /* load into S1, the contents of R0 */
	ADD R0, R0, #4 /* increment R0 to the next address */
	VMOV R2, S1
	VMOV R3, S0
	CMP R3, R2 /* if negative, S0, is updated */
	VMOVMI.F32 S0, S1
	SUB R1, R1, #1 /* decrement count */
	B maxF32_loop_start
maxF32_loop_end:
	VMOV R0, S0
	BX LR
