	.file	"vector.c"
	.option pic
	.text
	.section	.rodata
.hello_format_string:
	.string	"Hello, %s %s.\n"
.adjective_string:
	.string "cruel"
.world_string:
	.string "World"
	.text
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16


	li a2, 16
	vsetvli	t0, a2, e8


	li	a0,t0
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.section	.note.GNU-stack,"",@progbits	#set a non-executable program stack.
