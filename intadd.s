    .syntax unified

    @ Template file for Lab 3
    @ Whitney Larsen

    .arch armv7a
    .fpu vfp 

    @ --------------------------------
    .global intadd

intadd: /*operand 1 in r0, operand 2 in r1*/
	/*saving register 4, and the link register to the stack*/
	push 	{r4, lr} 

loop:
	/*if op1 AND op2 is 0, they can just be added because there are no carries*/
	ands	r4, r0, r1 
	beq	end
	/*if op1 AND op2 is not 0, left shift to get the carries as they'll be applied*/
	lsl	r4, r4, #1
	/*exlusive or op1 and op2 gives the result without carries*/
	eor	r1, r0, r1
	/*add the carries and the result without carries to get the final result*/
	mov	r0, r4
	b	loop
	

end:
	/*no carries at this point, so an exclussive or is just the result*/
	eor	r0, r0, r1
	/*restore r4 and go back to caller*/
	pop	{r4, pc}
