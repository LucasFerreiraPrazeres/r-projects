#!/bin/bash

# source host directory name
HOST=${1}
HOST_PATH="../hosts/${HOST}"

# collect data
for exp in $( ls ${HOST_PATH}/exp/exp-*.txt );
do
	exp_name=$( echo "${exp}" | rev | cut -d "/" -f 1 | rev )
	# times
	head -n 31 ${exp} | tail -n 30 | cut -d ' ' -f 8 | cut -d '=' -f 2 > /tmp/times-${exp_name}
	# packet error rate
	tail -n 2 ${exp} | head -n 1 | cut -d ' ' -f 6 | tr -d '%' > /tmp/per-${exp_name}
done

# save times tables
paste /tmp/times-exp-*-C.txt | tr '\t' ',' > ${HOST_PATH}/data/times-C.txt
paste /tmp/times-exp-*-D.txt | tr '\t' ',' > ${HOST_PATH}/data/times-D.txt

# save PER lists
cat /tmp/per-exp-*-C.txt > ${HOST_PATH}/data/per-C.txt
cat /tmp/per-exp-*-D.txt > ${HOST_PATH}/data/per-D.txt

# remove temp files
rm -f /tmp/times-exp-*.txt
rm -f /tmp/per-exp-*.txt
