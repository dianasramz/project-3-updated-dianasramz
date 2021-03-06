	.arch msp430g2553
	.p2align 1,0
	.extern red_on
	.extern led_update
	.extern led_changed
	
	.data
dim:
	.byte 0
	
	.text
jt:				;jump table
	.word case0		;state 0
	.word case1		;state 1
	.word case2		;state 2
	.word case3		;state 3

	.global dim_red_state

	
dim_red_state:
	mov &dim, r12		;dim is in r12
	cmp #4, &dim		;4 comparision
	jc out

	add r12, r12		;r12*2
	mov jt(r12), r0

case0:
	mov #1, &red_on		;turn on red
	mov.b #1, &dim		;dim set to 1
	jmp out
case1:
	mov #1, &red_on		;dim set to 2
	mov.b #1, &dim

case2:
	mov #1, red_on
	mov.b #1, &dim		;dim set to 3

case3:
	mov #0, &red_on
	mov.b #0, &dim
	jmp out
out:
	mov #1, led_changed	;led changed = 1
	call #led_update	;call led_update to activate led
	pop r0
	
	
