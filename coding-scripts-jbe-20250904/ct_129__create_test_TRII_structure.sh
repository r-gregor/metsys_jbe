#! /usr/bin/env bash

if [ ! -d "../TRII" ]; then
	mkdir -pv TRII/subtrii_1/{dir_1,dir_2}
	mkdir -pv TRII/subtrii_2/{dir_3,dir_4,dir_5}
	touch TRII/subtrii_1/dir_1/{sports,leisure,health}.txt
	mkdir -pv TRII/subtrii_2/dir_4/{food,clothing}
fi

