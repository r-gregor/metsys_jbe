#! /usr/bin/env bash

# 20230608:
#  - added: rm .bin/run
# ---

if [ ! -d ./bin ]; then
	mkdir -v ./bin
fi

gcc -g -Wall -o bin/run struct_serialization_v1.c

cmd="./bin/run"

${cmd} && rm ${cmd} 2>/dev/null

echo
cat ./people*
rm -i ./people*

