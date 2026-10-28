#! /usr/bin/env bash

# while IFS=';' read link path; do printf "%-30s --> %s\n" "${link}" "${path}"; done < sflinks.txt

ULB="${HOME}/.local/bin"

while IFS=';' read link path; do

	if [ -f ${path}.sh ]; then
		# TEST
		printf "ln -snf ${path}.sh ${ULB}/${link}\n"
		printf "mv -v ${ULB}/${link} ${ULB}/${link}.sh\n"
		#REAL DEAL
		# ln -snf "${path}.sh" "${ULB}/${link}"
		# mv -v "${ULB}/${link}" "${ULB}/${link}.sh"
	fi
done < sflinks.txt

