    .syntax unified

    @ Template file for Lab 3
    @ Whitney Larsen

    .arch armv7
    .fpu vfp 

    @ --------------------------------
    .global intsub

intsub:
	push	{lr}
	neg	r1, r1
	bl	intadd
	pop	{pc}
