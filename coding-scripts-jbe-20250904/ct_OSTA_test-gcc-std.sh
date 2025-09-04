#!/usr/bin/env bash

for std in c89 c99 c11 c17 c2x gnu89 gnu99 gnu11 gnu17; do
	echo $std
	gcc -std=$std -o ctest get-gcc-std.c
	./ctest
	echo
done

echo -n "default: "
gcc -o ctest get-gcc-std.c
./ctest
rm ./ctest
