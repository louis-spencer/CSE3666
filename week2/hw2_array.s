#       CSE 3666 HW 2
#	by Louis Spencer

        .text

#	i=s1, &A[0]=s2, &B[0]=s3
#
#	for (i = 0; i < 100; i += 1)
#		B[i] = A[i] + 4;
#

addi s1, x0, 0		# initialize i=0
addi t0, x0, 100	# initialize end=100
			# 2 instructions

loop:	
	slli t1, s1, 2	# calculate 4*i
	add t2, s2, t1	# t2 = A_address + offset
	add t3, s3, t1	# t3 = B_address + offset
	lw t4, 0(t2)	# load value into t4
	addi t4, t4, 4	# t4 += 4
	sw t4, 0(t3)	# save t4 into t3
	addi s1, s1, 1	# increment by 1
test:
	blt s1, t0, loop # 8 instructions per loop
