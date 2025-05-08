@ ARM Assembly - lab 3.2 
@ Group Number :

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
gcd:
    @ Base case: if b == 0, return a
    cmp r1, #0
    beq gcd_exit
    
    @ Prepare for recursive call: gcd(b, a % b)
    @ Save current a (r0)
    mov r2, r0
    
gcd_mod:
    cmp r2, r1
    blt gcd_mod_done
    sub r2, r2, r1
    b gcd_mod
gcd_mod_done:
    @ Now r2 contains a % b
    @ Move b to r0 and a%b to r1 for recursive call
    mov r0, r1
    mov r1, r2
    @ Recursive call
    b gcd
    
gcd_exit:
    @ Result is already in r0
    mov pc, lr
	










@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #64 	@the value a
	mov r5, #24 	@the value b
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl gcd
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
format: .asciz "gcd(%d,%d) = %d\n"

