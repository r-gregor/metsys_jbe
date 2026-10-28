#! /usr/bin/env bash

dirname=TESTDIR

if [ ! -d "../TRII" ]; then
	mkdir -pv ${dirname}
	for N in $(seq 1 10); do
		touch ${dirname}/file_${N}.txt
	done
fi

