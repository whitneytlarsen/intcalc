    .syntax unified

    @ Template file for Lab 3
    @ Whitney Larsen

    .arch armv7a
    .fpu vfp 

    @ --------------------------------
    .global intmul

intmul: /*multiplicand in r0, multiplier in r1*/
	push	{r4, r5, lr}
	mov	r4, r0 /*multiplicand in r4*/
	mov	r5, r1/*multiplier in r5*/
	mov	r0, #0 /*product in r0 and set to #0*/

loop:
	cmp	r5, #0 /*if the multiplier is #0, branch to the end*/
	beq	cleanup
	ands	r1, r5, #1
	beq	endif
	mov	r1, r4
	bl	intadd

endif:
	lsl	r4, #1
	lsr	r5, #1
	b	loop

cleanup:
	pop	{r4, r5, pc}
