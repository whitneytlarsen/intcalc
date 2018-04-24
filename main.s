    .syntax unified

    @ Template file for Lab 3
    @ Whitney Larsen

    .arch armv7a
    .fpu vfp 

    @ --------------------------------
    .global main
main:
	push	{lr}
    @ driver function main lives here, modify this for your other functions
loop:
	/*prompt for operand 1*/
	mov	r0, sp
	mov	r1, #12
	bl	intsub
	mov	sp, r0
	ldr	r0, =prompt1
	bl	printf
	/*put user answer onto stack*/
	mov	r1, sp
	ldr	r0, =scannum
	bl	scanf
	/*prompt for operand 2*/
	ldr	r0, =prompt2
	bl	printf
	/*put user answer onto stack*/
	mov	r0, sp
	mov	r1, #4
	bl	intadd
	mov	r1, r0
	ldr	r0, =scannum
	bl	scanf
	/*prompt for operation*/
	ldr	r0, =prompt3
	bl	printf
	/*put user answer onto stack*/
	mov	r0, sp
	mov	r1, #8
	bl	intadd
	mov	r1, r0
	ldr	r0, =scanchar
	bl	scanf
	ldrb	r0, [sp]
	ldrb	r1, [sp, #4]
	ldrb	r2, [sp, #8]
	pop	{r3}
	pop	{r3}
	pop	{r3}
if:
	/*check if operation is '+'*/
	ldr	r3, =add
	ldrb	r3, [r3]
	cmp	r3, r2
	bne	firstelse
	bl	intadd
	b	print
firstelse:
	/*check if operation is '-'*/
	ldr	r3, =sub
	ldrb	r3, [r3]
	cmp	r3, r2
	bne	secondelse
	bl	intsub
	b	print
secondelse:
	/*check if operation is '*'*/
	ldr	r3, =mul
	ldrb	r3, [r3]
	cmp	r3, r2
	bne	finalelse
	bl	intmul
	b	print
finalelse:
	/*report invalid operation*/
	ldr	r0, =printchar
	mov	r1, r2
	bl	printf
	ldr	r0, =invalid
	bl	printf
	b	askrepeat
print:
	/*print result, assumes answer is in r0*/
	mov	r1, r0
	ldr	r0, =result
	bl	printf
askrepeat:
	ldr	r0, =again
	bl	printf
    @ You'll need to scan characters for the operation and to determine
    @ if the program should repeat.
    @ To scan a character, and compare it to another, do the following
	mov	r0, sp
	mov	r1, #4
	bl	intsub
	mov	sp, r0
      ldr     r0, =scanchar
      mov     r1, sp          @ Save stack pointer to r1, you must create space
      bl      scanf           @ Scan user's answer
	mov	r0, sp
	mov	r1, #4
	bl	intadd
	mov	sp, r0
      ldr     r1, =yes        @ Put address of 'y' in r1
      ldrb    r1, [r1]        @ Load the actual character 'y' into r1
      ldrb	r0, [sp, #-4]        @ Put the user's value in r0
      cmp     r0, r1          @ Compare user's answer to char 'y'
      beq     loop              @ branch to appropriate location
      pop     {pc}
    @ this only works for character scans. You'll need a different
    @ format specifier for scanf for an integer ("%d"), and you'll
    @ need to use the ldr instruction instead of ldrb to load an int.

end:


yes:
    .byte   'y'
add:
    .byte   '+'
sub:
    .byte   '-'
mul:
    .byte   '*'
scanchar:
    .asciz  " %c"
prompt1:
    .asciz  "Enter Number 1: "
prompt2:
    .asciz  "Enter Number 2: "
prompt3:
    .asciz  "Enter Operation: "
result:
    .asciz  "Result is: %d"
again:
    .asciz  "\nAgain? "
scannum:
    .asciz  " %d"
invalid:
    .asciz  "Invalid Operation Entered."


