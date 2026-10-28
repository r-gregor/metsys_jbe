#! /usr/bin/env bash

if [ $# -ne 1 ]; then
	echo -e "\tUsage:\n\t\t$0 [fname]\n"
	exit
fi

fname=$1

rustc ${fname}
./${fname%.*}


