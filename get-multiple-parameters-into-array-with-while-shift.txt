#! /usr/bin/env bash
# fname: get-files-into-array-20260409.sh
# 20260409
# last: 20260409
# ---

declare -a fjls;

if [ $# -lt 1 ]; then
	echo -e "usage: $0 <filename>\n"
	exit
fi

while [ "$1" ]; do
	fjls+=("$1")
	shift
done

if [ "${#fjls[@]}" -lt 1 ]; then
	printf "[INFO] No files selected"
	exit
fi

for ((i=0; i<"${#fjls[@]}"; i++)); do
	if [ ! -f "${fjls[i]}" ]; then
		printf "[ERROR] file: '%s' does NOT exist\n" "${fjls[i]}"
		printf "\n"
		exit
	fi
done

for fname in "${fjls[@]}"; do
	printf "filename: %s\n" "${fname}"
done

printf "\n"

