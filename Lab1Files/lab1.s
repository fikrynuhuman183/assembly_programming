@ ARM Assembly - Lab 1
@ E Number : E/21/138
@ Name : Fikry

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values
	ldr r0, =array_a
	ldr r1, =array_b
	mov r2, #3
	mov r3, #7
	mov r4, #10

	
	@ Write YOUR CODE HERE
	@ b[4] = 6 + a[9] - a[3] + b[1] – ( c + d - e )
	@ Base address of a in r0
	@ Base address of b in r1
	@ c,d,e in r2,r3,r4 respectively 

	@ ---------------------

	
	LDR r5,[r0,#12] @ r5 gets a[3]
	LDR r6,[r0,#36] @ r6 gets a[9]
	SUB r7,r6,r5 	@ r7 gets a[9] - a[3]

	
	LDR r5,[r1,#4] 	@ r5 gets b[1]
	ADD r6,r5,r7 	@ r6 gets a[9] - a[3] + b[1]

	
	ADD r5,r2,r3 	@ r5 gets c+d
	SUB r2,r5,r4 	@ r2 gets c+d-e 
	SUB r3, r6,r2 	@ r3 gets a[9] - a[3] + b[1] – ( c + d - e )
	mov r5, #6 		@ r5 gets 6
	ADD r2, r3,r5 	@ r2 gets 6 + a[9] - a[3] + b[1] – ( c + d - e )
	STR r2,[r1,#16] @ Store the result in b[4]
 


	@ ---------------------
	
	
	@ load aguments and print
	ldr r0, =format
	ldr r2, =array_b
	ldr r1, [r2,#16]
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	
	
	.data	@ data memory
	
format: .asciz "The Answer is %d (Expect -3 if correct)\n"
	
	@array called array_a of size 40 bytes
	.balign 4 			@align to an address of multiple of 4
array_a: .word 1,5,7,67,5,54,65,23,34,54

	@array called array_b of size 20 bytes
	.balign 4 			@align to an address of multiple of 4
array_b: .word 7,4,8,3,5
