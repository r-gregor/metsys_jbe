#! /usr/bin/env bash

if [ $# -ne 3 ]; then
	echo -e "\n\tusage: <filename.c>  <start_pos>  <subs_len>"
	echo -e "\t\tstart_pos ... [int]"
	echo -e "\t\tsubs_len  ... [int]"
	echo ""
	exit 1
fi

path=${1}
fname=$(basename ${path})
target=${fname//.c/}

if [ ! -f ${path} ]; then
	echo "[ERROR] no such file: ${path}"
	exit 1
fi

sp=$2
sl=$3

echo "[INFO] building and running ${fname} ..."
echo "---"
 # gcc -o && ./bin/${fname//.c/.exe} ${sp} ${sl}
gcc -Wall -o ./bin/${target} ${path} && ./bin/${target} ${sp} ${sl}


