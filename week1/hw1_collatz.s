#       CSE 3666 HW 1
#       by Louis Spencer

        .text       
        
main: 	# use system call 5 to read integer
        addi    a7, x0, 5
        ecall
        addi    s1, a0, 0       # copy to s1
        
	addi s2, x0, 1	#	init s2 as 1 for comparison instructions
        addi s3, x0, 0	#	init s3 as Collatz stopping time
        
        # s1 = n, s2 = 1, s3 = t
        
        # from wikipedia:
        # - if the number is even, divide it by two
        # - if the number is odd, triple it and add one
        # repeat until the number is 1
        
	beq x0, x0, while_test

while:
	addi s3, s3, 1	  	#	increment the time by 1
	andi t0, s1, 0x01 	#	mask the last bit for even/odd
	beq t0, x0, else_even 	#	if even, goto else_even
	# if odd
	add t1, x0, s1		#	use another temporary variable to store n
				#	otherwise funny shenanigans
				
	slli s1, s1, 1		#	slli 1 --> n << 1 --> n * 2
	add s1, s1, t1		#	add --> 2*n + n = 3*n
				#	use temporary variable for addition
				
	addi s1, s1, 1		#	3*n + 1
	beq x0, x0, while_test 	#	test new value of n

else_even:
	# if even
	srai s1, s1, 1		#	srai 1 --> n >> 1 --> n / 2
	beq x0, x0, while_test 	#	test new value of n

while_test:
	bne s2, s1, while 	#	if s1 != 1, loop until it is

	# print out the stopping time 
print:	addi a7 x0, 1
	add a0, x0, s3
	ecall

        # exit
exit:   addi    a7, x0, 10      
        ecall
        
	