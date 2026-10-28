#! /usr/bin/env bash

if [ $# -eq 1 ]; then
	fname=$1
else
	echo "Must supply [filename].c to compile"
	exit
fi

if [ ! -f ${fname} ]; then
	echo "File ${fname} does NOT exist!"
	exit
fi

if [ ! -d ./bin ]; then
	echo "No 'bin/ directory. Creating one ..."
	mkdir ./bin
:wq
fi

fname_base=${fname//.c/}

# set -xe

# compile
gcc -Wall -Wextra -o bin/${fname_base} ${fname}
# clang -Wall -Wextra -Werror -o bin/${fname_base} ${fname}
# clang -Wall -Wextra -o bin/${fname_base} ${fname}

# run
echo "OUTPUT:"
./bin/${fname_base}

