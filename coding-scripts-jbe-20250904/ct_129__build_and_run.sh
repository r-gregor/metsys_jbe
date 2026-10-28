#! /usr/bin/env bash

bindir="./bin"

if [ ! -d ${bindir} ]; then
	echo -e "---\n[INFO] No 'bin' directory found ... creating one"
	mkdir -v ${bindir}
fi

echo -e "---\n[INFO] Building and runing ubuild.c ...\n"
gcc -o ${bindir}/ubuild ubuild.c && ${bindir}/ubuild

echo -e "---\n[INFO] Building and runing uconcat.c ...\n"
gcc -o ${bindir}/uconcat uconcat.c && ${bindir}/uconcat

echo -e "---\n[INFO] Building and runing for_each_file_in_dir.c ...\n"
gcc -o ${bindir}/for_each_file_in_dir for_each_file_in_dir.c && ${bindir}/for_each_file_in_dir

