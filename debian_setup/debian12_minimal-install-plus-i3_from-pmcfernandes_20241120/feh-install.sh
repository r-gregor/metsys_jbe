#!/bin/bash

sudo apt install -y feh

mkdir $HOME/Pictures && cd $HOME/Pictures

wget -o ghost2.jpg https://github.com/elithrade/manjaro-i3/raw/master/wallpapers/ghost2.jpg

feh --bg-scale $HOME/Pictures/ghost2.jpg