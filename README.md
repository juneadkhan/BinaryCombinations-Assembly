# BinaryCombinations in Assembly Language 0️⃣1️⃣1️⃣0️⃣

Given a positive integer number N, this programme generates all the possible binary combinations of N bits. This implementation is done via recursion. The code uses MIPS Stack Allocation/Deallocation conventions.

- **Recursive Solution** following MIPS Calling Conventions
- Written in **Assembly Language** for the **MIPS** Architecture.
- MIPS is a **RISC Instruction Set Architecture**
- Written, Tested and Simulated using **MARS MIPS Simulator** ([MSU](http://courses.missouristate.edu/kenvollmar/mars/))

#### Code Snippet:

``` assembly
binarygenerator:
				# a0 represents n
        addiu	$sp, $sp, -12 
        			# Save in Stack
	sw	$ra, 0($sp)
	sw	$a0, 4($sp)
	sw	$a1, 8($sp) 
	
	ble $a1, $0, else 	# if n > 0 is FALSE, do Else
	
	subu $t2, $a0, $a1 	# t2 = N-n
	
				# pattern[N-n] = '0';
	
 	la $s0, pattern	 	# store address of array A in $s0
 	
	add $s0, $s0, $t2
	addi $t3, $0, '0'
	sb $t3, ($s0)
	
				#Store original n in stack
	addi $sp, $sp, -4
	sw $a1, 12($sp) 
	
	addi $a1, $a1, -1 	# n-1
	
				# binarygenerator(N, n - 1 );
	jal binarygenerator
	
				# pattern[N-n] = '1';
	
	lw $a1, 12($sp)		# retrieve original n 
	
	addi $sp, $sp, 4 	# Deallocate from Stack
	
	subu $t2, $a0, $a1 	# t2 = N-n
	
	la $s0, pattern		# store address of array A in $s0
 	
	add $s0, $s0, $t2
	addi $t3, $0, '1'
	sb $t3, ($s0)
	
				#Store original n in stack
	addi $sp, $sp, -4
	sw $a1, 12($sp) 
	
	
	addi $a1, $a1, -1 	# n-1
	
				# binarygenerator( N, n - 1 );
	jal binarygenerator
	
	lw $a1, 12($sp) 	# retrieve original n 
	
	addi $sp, $sp, 4	# Deallocate from Stack
	
	lw	$a1, 8($sp)
	lw	$a0, 4($sp)
	lw	$ra, 0($sp)
	addi	$sp, $sp, 12 	# return stack pointer
	jr	$ra
	
				# else printf( "%s\n", pattern );
```
