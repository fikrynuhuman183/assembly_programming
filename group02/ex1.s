@ ARM Assembly - exercise 1 template
@ 


	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values
	@ a,b,c,d,e in r0,r1,r2,r3,r4 respectively
	mov r0, #10
	mov r1, #5
	mov r2, #7
	mov r3, #-8
	mov r4, #3
	
	@ Write YOUR CODE HERE
	@ f=a+b-c-d+e
	@ Put f to r5
	@ ---------------------
	
	ADD r5,r0,r1
	ADD r0,r5,r4
	SUB r1,r0,r2
	SUB r5,r1,r3

	
	
	
	
	
	
	
	@ ---------------------
	
	
	@ load aguments and print
	ldr r0, =format
	mov r1, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "The Answer is %d (Expect 19 if correct)\n"


