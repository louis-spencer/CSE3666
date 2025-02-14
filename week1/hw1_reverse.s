#       CSE 3666 HW 1
#       by Louis Spencer

        .text
main:   
	# load s2 with 32 bit number
	lui s2, 0x12345
	addi s2, s2, 0x678
	
	# goto if
	beq x0, x0, if
while:
	
	andi t0, s2, 0xff	# bitmask just the last two values
	srli s2, s2, 8		# shift left s2 to get the next set
	slli s4, s4, 8		# shift right s4 to insert the new values
	or s4, s4, t0		# insert the new values using OR
	
# check to see if s2 is 0x00
if: bne s2, x0, while

        # sys call to exit
exit:   addi    a7, x0, 10      
        ecall
