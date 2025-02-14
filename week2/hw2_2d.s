#       CSE 3666 HW 2
#	by Louis Spencer

        .text
        
#	T[0][0] = 1000 + 0 * 4
#	T[1][0] = 1000 + 8 * 4
#	T[0][1] = 1000 + 7 * 4
#	T[M][N] = s9 + (8*M + N) * 4
#	mem addr = s9 + (8*M + N) * 4
#	where M is the row and N is the col

addi s1, x0, 16	# max cols
addi s2, x0, 8	# max rows

addi t1, x0, 0	# i, cols
		# initialize temporary variable for i
for_cols:

	addi t2, x0, 0	# j, rows
			# initialize temporary variable for j
	for_rows:
	
		slli t3, t1, 8	# t3 = 256 * i = i << 8
		addi t3, t3, t2	# t3 += j
				# t3 = 256*i + j
				
		slli t4, t2, 3	# t4 = 8*j = j << 3
		add  t4, t4, t1 # t4 = t4 + i
		slli t4, t4, 2	# t4 = 4*t4 = t4 << 2
		add t4, t4, s9  # t4 += s9
				# t4 = 4*(8*M + N) + s9
				
		sw t3, 0(t4)	# store t3 into t4 + 2d_offset

		addi t2, t2, 1 	# increment j by 1
	test_for_rows:
		blt, t2, s2, for_rows	# when j < 8, inner loop again
		
	addi t1, t1, 1	# increment i by 1
test_for_cols:
	blt t1, s1, for_cols	# when i < 16, outer loop again
	

