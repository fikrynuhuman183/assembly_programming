@ ARM Assembly - lab 2
@ Group Number :

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values
	
	@ Write YOUR CODE HERE
	
	@	Sum = 0;
	@	for (i=0;i<10;i++){
	@			for(j=5;j<15;j++){
	@				if(i+j<10) sum+=i*2
	@				else sum+=(i&j);	
	@			}	
	@	} 
	@ Put final sum to r5


	@ ---------------------
	
	MOV r0, #0 @Assign 0 to SUM
	MOV r1, #0 @Assign 0 to i
	
	Loop1: @Start Loop 1
	CMP r1,#10
	BGE End
		
	MOV r2,#5
	B Loop2
	
	ADD r1,#1
	B Loop1
	
	Loop2:
	
	CMP r2,#15
	BGE EndLoop1
	
	ADD r3, r1,r2
	
	CMP r3,#10
	BLT sum2i
	
	AND r4, r1,r2
	ADD r0,r0,r4
	B EndLoop2
	
	
	sum2i:
	ADD r5,r1,r1
	ADD r0,r5,r0
	B EndLoop2
	
	EndLoop2:
	ADD r2,r2,#1
	B Loop2
	
	EndLoop1:
	ADD r1,r1,#1
	B Loop1
	
	End:
	MOV r5,r0
	
	
	
	
	
	
	
	
	
	
	
	
	
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
format: .asciz "The Answer is %d (Expect 300 if correct)\n"

