@ ARM Assembly - lab 3.1
@ 
@ Roshan Ragel - roshanr@pdn.ac.lk
@ Hasindu Gamaarachchi - hasindu@ce.pdn.ac.lk

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
@ r0 is x, r1 is n

mypow:

SUB sp,sp,#12
STR r4,[sp,#0]
STR r5,[sp,#4]
STR r6,[sp,#8]

MOV r4,#1
MOV r5,r0

loop:
CMP r4,r1
BGE end
MUL r6,r5,r0
MOV r5,r6
ADD r4,#1
B loop

end:
MOV r0,r5
LDR r4,[sp,#0]
LDR r5,[sp,#4]
LDR r6,[sp,#8]
ADD sp,sp,#12
MOV pc,lr


@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8	@the value x
	mov r5, #3 	@the value n
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl mypow
	mov r6,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	mov r3, r6
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "%d^%d is %d\n"

