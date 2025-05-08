@ ARM Assembly - exercise 5
@ Group Number :

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]
	
	@ Write YOUR CODE HERE
	
	@ j=0;
	@ for (i=0;i<10;i++)
	@ 		j+=i;	
	
	@ Put final j to r5

	@ ---------------------

	MOV r5, #0 @Assign 0 to r5 which is j
	MOV r2, #0 @Assign 0 to r2 which is i
	Loop:
		CMP r2,#10 @compare i with 10
		BGE Exit   @if i >=10 exit
		ADD r5, r5,r2 @Add i and j
		ADD r2,r2,#1  @Add 1 to i
		B Loop @Branch to loop to continue the loop
	Exit:
		
	
	
	
	
	
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
format: .asciz "The Answer is %d (Expect 45 if correct)\n"

