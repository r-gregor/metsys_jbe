#! /usr/bin/env bash

if [ $# -ne 1 ]; then
	echo "Must supply single parameter: <filename>.py"
	exit 
fi

./venv/Scripts/python $1 2>/dev/null &

