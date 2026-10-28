#! /usr/bin/env bash

if [ ! $# -eq 1 ]; then
	exit
else
	incr=$1
fi

font_name=$(grep xft $HOME/.Xresources | head -n1 | cut -d: -f3)
font_size=$(grep xft $HOME/.Xresources | head -n1 | cut -d: -f5 | cut -d= -f2)

printf "\33]50;%s\007" "xft:${font_name}-$(( ${font_size} + ${incr} ))"

