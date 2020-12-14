#!/bin/bash
# Check if there are differences between two file
VAR=`diff output.txt ../LFSR/ModelSim/LFSR_test/fileout.tv`
if [ -z "$VAR" ]
then
	echo "OK - NO DIFFERENCES"
else
	echo $VAR
fi
echo "Press a key to exit"
read input
