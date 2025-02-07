#       CSE 3666 HW 1
#       by Louis Spencer

        .text

#	for (i = 0; i < a; i+= 1)
#		if ((i & 0xa5) != 0)
#			r ^= i << 8
#		else
#			r += i >> 4

#	a = s1, i = s2, r = s3
#
#	a, i, and r are already set,
#	no  need to initalize them

for:
	bge s2, s1, exit  #	exit from for loop if i >= a
	andi t0, s2, 0xA5 #	t0 = i & 0xa5
	
	addi t1, s2, 0		# temporary variable to capture s2
	
	addi s2, s2, 1	  #	increment counter by 1
			  
	beq t0, x0, else  #	if (t0 == 0) goto else
	
	# execute if statement
	slli t0, t1, 8	#	t0 = i << 8
	xor s3, s3, t0	#	s3 = s3 ^ t0
	beq x0, x0, for	#	loop again
	
else:
	# execute else statement
	# use shift right arithmetic (as per c)
	srai t0, t1, 4	#	t0 = i >> 4
	add s3, s3, t0	#	s3 = s3 + t0
	beq x0, x0, for	#	go back to start of loop
	
exit: 	# end of the foor loop