#! /usr/bin/env bash

if [ -f ./demo ]; then
	 ./demo
else
	gcc -o demo horse_race.c && ./demo
fi

