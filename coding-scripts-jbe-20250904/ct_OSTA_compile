#! /usr/bin/env bash

run_gcc() {
	progname=$1
	echo -n "Compiling ${progname}.c ... "
	gcc -Wall -o ./target/${progname} ./src/${progname}.c -lncurses
	echo "OK"
}

progs=()
readarray -t -O "${#progs[@]}" progs < <(ls -1 ./src/*.c)

for (( i=0; i<${#progs[@]}; i++ )); do
	path=$(basename ${progs[$i]})
	prg=${path//.c/}
	run_gcc ${prg}
done

