#!/bin/bash
# Check if there are differences between two file
#VAR=`diff output.txt ../LFSR/ModelSim/LFSR_test/fileout.tv`		# TEST 1 OK
#VAR=`diff output1.txt ../LFSR/ModelSim/LFSR_test/fileout1.tv`  	# TEST 2 OK
#VAR=`diff output2.txt ../LFSR/ModelSim/LFSR_test/fileout2.tv`		# TEST 3 OK
# Wrapper Test (the output.txt remain the same of TEST 1 because isTap and seed are the same)
VAR=`diff output.txt ../LFSR/ModelSim/LFSR_wrapper_test/fileout_wrapper.tv`

if [ -z "$VAR" ]
then
	echo "OK - NO DIFFERENCES"
else
	echo $VAR
fi
echo "Press a key to exit"
read input
