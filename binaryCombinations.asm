.data
pattern: 	.space 17	# array of 16 (1 byte) characters (i.e. string) plus one additional character to store the null terminator when N=16
N_prompt:	.asciiz 	"Enter the number of bits (N): "
newline: 	.asciiz 	"\n"
.text

main:
 				# Print the prompt for N
  addi 	$v0, $0, 4  		# system call 4 is for printing a string
  la  $a0, N_prompt		# address of N_prompt is in $a0
  syscall           		# print the string
  				
  addi	$v0, $0, 5 		# system call 5 is for reading an integer, Read N
  syscall  			# integer value read is in $v0
  
  add	$t0, $0, $v0   		# copy N into $t0 
  add $t1, $t0, $0  		#t1 = n = N
  
  add $a0, $t0, $0 		# N
  add $a1, $t1, $0 		# n
  
  la $s0, pattern 		# store address of array A in $s0
  addi $t0, $a0, 1 		# N+1
  
  add $s0, $s0, $t0
  
  addi $t1, $0, '\0' 		# Null Terminator
  sb $t1, ($s0)
  
  jal binarygenerator
  j exit

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
else:
	
	add $t4, $a0, $0 	# Store a0 temporarily in t4
	
	addi $v0, $0, 4		# System call (4) to print string.
	la $a0, pattern		# Put string memory address in register $a0.
	syscall			# Print string.
	
	addi $v0, $0, 4  	# system call (4) to print string
	la $a0, newline		# put string memory address in register $a0 
	syscall  		# NEWLINE 
	
	add $a0, $t4, $0
	
				# Deallocate Stack
	lw	$a1, 8($sp)
	lw	$a0, 4($sp)
	lw	$ra, 0($sp)
	addi	$sp, $sp, 12 	# return stack pointer
	jr	$ra


exit:             
 	addi $v0, $0, 10      	# system call code 10 for exit
  	syscall               	# exit the program
