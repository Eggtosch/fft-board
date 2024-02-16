.syntax unified
.cpu cortex-m4
.thumb

.global vector_table
.global reset_handler
.global main

.type vector_table, %object
vector_table:
	.word _estack
	.word reset_handler
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0

.size vector_table, . - vector_table

.type reset_handler, %function
reset_handler:
// set stack pointer
	LDR r0, =_estack
	MOV sp, r0

// copy data section to ram
	MOVS r0, #0
	LDR  r1, =_sdata
	LDR  r2, =_edata
	LDR  r3, =_sidata
	B    copy_sidata_loop
copy_sidata:
	LDR  r4, [r3, r0]
	STR  r4, [r1, r0]
	ADDS r0, r0, #4
copy_sidata_loop:
	ADDS r4, r0, r1
	CMP  r4, r2
	BCC  copy_sidata

// initialize bss region in ram to 0
	MOVS r0, #0
	LDR  r1, =_sbss
	LDR  r2, =_ebss
	B    reset_bss_loop
reset_bss:
	STR  r0, [r1]
	ADDS r1, r1, #4
reset_bss_loop:
	CMP  r1, r2
	BCC  reset_bss

// jump to main
	B main

// endless loop when main returns
main_loop:
	B main_loop

.size reset_handler, . - reset_handler
