#! /bin/bash
# filename: softlink1_fname_to_ulb.sh
# 20190131 v1
# 20260512 v2 lin to original name with .sh extension
# last: 20260512
#


# test if filename supplied as argument
if [ ! $# -eq 1 ]; then
    echo "Usage:"
    echo -e "$0 [scriptname]\n"
    exit
fi

source_path=$(dirname $1)
dest_path="$HOME/.local/bin"

fname_full=$(basename $1)
# fname=${fname_full%%.*}
# ext=${fname_full##*.}


# tests
# echo "Source path: ${source_path}"
# echo "Destination path: ${dest_path}"
# echo "Complete filename: ${fname_full}"
# echo "Filename without extension: ${fname}"
# echo "Extension only: ${ext}"


# test if filename exists
if [ ! -e ${source_path}/${fname_full} ]; then
    echo -e "file: ${fname_full} NOT found!\n"
    exit
fi

# execute
echo "Soft-linking ${fname_full} to ~/.local/bin/ ..."
sudo ln -sv $(realpath ${source_path}/${fname_full}) ${dest_path}/${fname_full}

