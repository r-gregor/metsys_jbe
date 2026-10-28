#! /usr/bin/env bash


# FJL=$(realpath $1)
# FJL_pth=$(dirname ${FJL})
# FJL_pth_new="${FJL_pth}/0_converted_to_PDF"
# FJL_fnm=$(basename ${FJL})
# FJL_nm=${FJL_fnm%%.*}
# FJL_ext=${FJL_fnm##*.}
# FJLPS="${FJL_pth_new}/${FJL_nm}.ps"
# FJLPDF="${FJL_pth_new}/${FJL_nm}.pdf"

for FAJL in $(ls -1 ./1_converted_to_PDF/*.pdf); do
	FJL_fnm=$(basename ${FAJL})
	FJL_nm=${FJL_fnm%%.*}
	# echo "${PWD}/${FJL_nm}.txt --> 0_converted_to_PDF/${FJL_nm}.pdf"
	# echo "~/.local/bin/b-convert-txt-to-pdf-en ${PWD}/${FJL_nm}.txt"
	~/.local/bin/b-convert-txt-to-pdf-en ${PWD}/${FJL_nm}.txt
done

