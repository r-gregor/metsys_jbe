#! /usr/bin/env bash

TARGET=$PWD

OUT="${TARGET}/zig-out"
CCH="${TARGET}/.zig-cache"

echo "Dirs to remove:" 
echo "${OUT}"
echo "${CCH}"
read -p "OK ?"

rm -rv ${OUT} ${CCH}

