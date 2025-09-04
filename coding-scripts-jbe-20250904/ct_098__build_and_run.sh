#! /usr/bin/env bash

echo "Compiling ..."
gcc -Wall -o ./bin/reversed ./src/reverse.c

echo -e "Running ...\n"
./bin/reversed.exe


