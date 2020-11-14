	.file	"vector.c"
	.option pic
	.text
	.section	.rodata
.hello_format_string:
	.string	"Hello, %s.\n"
.adjective_string:
	.string "cruel"
.world_string:
	.string "WWWWW"
.caeasar_iter:
	.byte 0x01, 0x01, 0x01, 0x01, 0x01
	.text
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	addi	sp,sp,-64
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,80

	li a0, 32
	call malloc@plt

	# put the string on the stack.
	lla	a3, .caeasar_iter

	lla	a4, .world_string
	lla	a5, .caeasar_iter


	# I want 16 4-byte items to fill each vector.
	li	a2, 5
	vsetvli	t0, a2, e8, m1
	vlbu.v	v0, (a4)
	vlbu.v	v1, (a5)
	vadd.vv	v0, v0, v1
	vsb.v	v0, (a0)

	mv a1, a0
	lla a0, .hello_format_string
	call printf@plt

	mv	a0,t0
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	addi	sp,sp,64
	jr	ra
	.size	main, .-main
	.section	.note.GNU-stack,"",@progbits	#set a non-executable program stack.
