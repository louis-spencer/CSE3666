#       CSE 3666 HW 1
#       by Louis Spencer

        .text
main:   
	lui s0, 0xFFFF0		# load test value into s0
	addi s0, s0, 0x001	
	# ---------------- do not include above in final line count
	
	addi s1, x0, 0		# given, init s1 
	add t0, x0, s0		# make a copy so s0 is not changed
loop:
	bge t0, x0, skip	# instead of masking, check sign as 1
				# if t0 >= 0. If it is, dont add to count
	
	addi s1, s1, 1		# add 1 if t0 'sign' is 1
skip:
	slli t0, t0, 1		# shift t0 to right, new 'sign' bit to check
	bne t0, x0, loop	# keep looping until shifted out completely
	
exit:   addi    a7, x0, 10      
        ecall
