	.file	"play.c"	# Tell 'as' that we are about to start a new logical file.
	.option pic		# Tell 'as' to generate position-independent code.
	.text			# Statements from here will be assembled on to the end of the text subsection of the output file.
	.section	.rodata	# Create a section name '.rodata' and assemble the following into that section.
.hello_format_string:
	.string	"Hello, %s %s.\n"
.adjective_string:
	.string "cruel"
.world_string:
	.string "World"
	.text			# Back to the text section 0.
	.globl	main		# Make the `main` symbol visible to the linker.
	.type	main, @function	# Mark the `main` symbol as a function.
main:
	addi	sp,sp,-16 #establish stack space by subtracting 16 from the sp.
	sd	ra,8(sp)  #save ra and s0 on to the stack.
	sd	s0,0(sp)
	addi	s0,sp,16  #set the frame pointer (s0)

# a0 is the first parameter to the function.
	lla	a0,.hello_format_string	#load local address. The address of the string will go in a0
# a1 is the second parameter to the function.
	lla	a1,.adjective_string 	#load local address. The address of the string will go in a0
# a2 is the third parameter to the function.
	lla	a2,.world_string	#load local address. The address of the string will go in a0

#	call	printf@plt  #Now, invoke the printf function.
# call expands to jalr ra, call destination (in a register).
# so, we can rewrite
# call printf@plt 
# as
# la	ra, print # load the address of printf into register ra.
	la	ra, printf
# jalr	ra, 0(ra) # jump to 0 + ra and load pc + 4 into ra.
	jalr	ra, 0(ra)

	mv	a0,a0     #Use the printf return value as our return value.
#	li	a0,3      #Load 3 into a0. a0 is the register that holds the return value for this function.
	ld	ra,8(sp)  #Restore ra and s0 from the stack.
	ld	s0,0(sp)
	addi	sp,sp,16  #Restore the stack pointer.
	jr	ra        #Jump to the return address.
	.size	main, .-main
	.section	.note.GNU-stack,"",@progbits	#set a non-executable program stack.
