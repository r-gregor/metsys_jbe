#! /usr/bin/env bash
# fname: find-en-only-commands-in-majbin-en.sh
# descpt: find and display commands in 'majbin' that work on win only (en_only)
# 20261007 v1
# last: 20261007
# ---

# === GLOBALS ===
src_dir="${HOME}/majstaf/majbin"
en_dir="${src_dir}/en_only"
tdceon="this_directory_contains_en_only_commands.txt"

# === MAIN ===
for found_f in $(find "${src_dir}"/* -maxdepth 2 | grep -v 'arch\|test\|en_only'); do
	#mjb_found="${found_f/${src_dir}\/}"
	grep -r -- 'gregor.redelonghi\|gredelonghi\|-en' "${found_f}" >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		mjb_found="${found_f/${src_dir}\/}"
		if [[ "${mjb_found}" =~ / ]]; then
			continue
		elif [ -d "${mjb_found}" ] && [ ! -f "${mjb_found}/${tdceon}" ]; then
			continue
		else
			printf "%s\n" "${mjb_found}" | grep -v "\.exe\|\.txt\|\.py"
			# printf "%s\n" "${mjb_found}"
		fi
	fi
done

printf "\n"

