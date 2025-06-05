@ lab4.s - ARM Assembly program to reverse input strings
@ Author: [Your Name]
@ Date: [Current Date]

.data
prompt_num:     .asciz "Enter the number of strings:\n"
invalid_msg:    .asciz "Invalid Number\n"
prompt_str:     .asciz "Enter input string %d:\n"
output_str:     .asciz "Output string %d is...\n%s\n"
input_buffer:   .space 200       @ Buffer for input strings

.text
.global main

@ Function to reverse a string
@ Input: r0 - address of string to reverse
reverse_string:
    push {r4-r6, lr}
    mov r1, r0                  @ r1 points to start of string
    
    @ Find the end of the string
    mov r2, #0
find_end:
    ldrb r3, [r1, r2]
    cmp r3, #0
    beq end_found
    add r2, r2, #1
    b find_end
    
end_found:
    @ r2 now contains string length
    cmp r2, #0
    beq reverse_done            @ empty string, nothing to do
    
    sub r2, r2, #1              @ r2 = last index (length-1)
    mov r4, #0                  @ r4 = start index
    
reverse_loop:
    cmp r4, r2
    bge reverse_done
    
    @ Load characters from both ends
    ldrb r5, [r0, r4]           @ char from start
    ldrb r6, [r0, r2]           @ char from end
    
    @ Swap them
    strb r6, [r0, r4]
    strb r5, [r0, r2]
    
    @ Move indices
    add r4, r4, #1
    sub r2, r2, #1
    b reverse_loop
    
reverse_done:
    pop {r4-r6, pc}

main:
    push {r4-r8, lr}
    
    @ Prompt for number of strings
    ldr r0, =prompt_num
    bl printf
    
    @ Read number of strings
    ldr r0, =input_buffer
    bl gets
    bl atoi
    mov r4, r0                  @ r4 = number of strings
    
    @ Validate input
    cmp r4, #0
    blt invalid_input
    beq exit_program            @ 0 strings is valid, just exit
    
    @ Loop through strings
    mov r5, #0                  @ r5 = current string index
string_loop:
    cmp r5, r4
    bge exit_program
    
    @ Prompt for string input
    ldr r0, =prompt_str
    mov r1, r5
    bl printf
    
    @ Read string
    ldr r0, =input_buffer
    bl gets
    
    @ Reverse the string
    ldr r0, =input_buffer
    bl reverse_string
    
    @ Print the reversed string
    ldr r0, =output_str
    mov r1, r5
    ldr r2, =input_buffer
    bl printf
    
    @ Increment counter and loop
    add r5, r5, #1
    b string_loop
    
invalid_input:
    ldr r0, =invalid_msg
    bl printf
    
exit_program:
    mov r0, #0                  @ return 0
    pop {r4-r8, pc}
    bx lr