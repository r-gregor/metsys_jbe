#! /usr/bin/env bash
# fname: re-softlink-en-only.sh
# descpt: re-link existing soft link in '~/.local/bin/' to new (target) command
# 20261007 v1
# last: 20261007
# ---

if [ $# -ne 1 ]; then
	printf "[E]usage: re-softlink-en-only <file type (sh, exe, py)>\n\n"
	exit 1
else
	EXT="$1"
fi

if [ "${EXT}" != 'sh' ] && [ "${EXT}" != 'exe' ] && [ "${EXT}" != 'py' ]; then
	printf "[E] no such file type: '*.%s'\n\n" "${EXT}"
	exit 1
fi

# === MAIN ===
for ENCMD in $(find ./en_only/ -type f -iname "*.${EXT}"); do
	full_path=$(realpath "${ENCMD}")
	dot_loc_bin_path="${HOME}/.local/bin"
	fname_only="${ENCMD##.*/}"
	fname_no_ext="${fname_only%.*}"
	printf "[i] soft-linkig '%s' to '%s'\n" "${full_path}" "${dot_loc_bin_path}/${fname_no_ext}"
	ln -snf "${full_path}" "${dot_loc_bin_path}/${fname_no_ext}"
done

printf "\n"

