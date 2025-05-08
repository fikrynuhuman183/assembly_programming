@ ARM Assembly - exercise 6 
@ Group Number :

	.text 	@ instruction memory
	
	
@ Write YOUR CODE HERE	

@ ---------------------	


fact:
SUB sp, sp,#8
STR r5, [sp,#4]
STR r4, [sp,#0]
MOV r4,r0
SUB r0,#1
B loop

loop:
CMP r0,#1
BLE end
MUL r5,r4,r0
MOV r4,r5
SUB r0,r0,#1
B loop

end:
MOV r0,r4
LDR r4,[sp,#0]
LDR r5,[sp,#4]
ADD sp,#8
MOV pc,lr

@ ---------------------	

.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value n

	@ calling the fact function
	mov r0, r4 	@the arg1 load
	bl fact
	mov r5,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "Factorial of %d is %d\n"

