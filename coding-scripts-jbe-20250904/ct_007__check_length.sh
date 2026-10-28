#! /usr/bin/env bash

N=0
for FFF in *; do
	SF=${#FFF}
	if [ ${SF} -gt $N ];then
		N=${SF}
		fjl=$FFF
	fi
done
printf "The file with max letters [%d] is \"%s\"\n" $N $fjl


