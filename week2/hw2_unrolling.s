#       CSE 3666 HW 2
#	by Louis Spencer

        .text
#	i=s1, &A[0]=s2, &B[0]=s3        


addi s1, x0, 0		# initialize values
addi t4, x0, 100	# 2 instructions

loop:
	slli t0, s1, 2	# calculate 4*i
			# proper indexing in memory
			
	add t1, s2, t0	# t1 = offset + A_addr
	add t2, s3, t0	# t2 = offset + B_addr
	
	lw t3, 0(t1)	# load A[0+t1] into t3 
	addi t3, t3, 4	# t3 += 4
	sw t3, 0(t2)	# save t3 into B[0+t1]
			# repeat, incrementing offset
	lw t3, 1(t1)
	addi t3, t3, 4
	sw t3, 1(t2)
	
	lw t3, 2(t1)
	addi t3, t3, 4
	sw t3, 2(t2)
	
	lw t3, 3(t1)
	addi t3, t3, 4
	sw t3, 3(t2)
	
	addi s1, s1, 4	# increment by 4
test:
	blt s1, t4, loop # 17 instructions per loop
