#!/bin/bash

cd $HOME

mkdir ~/.urxvt && mkdir ~/.urxvt/ext

sudo apt install -y git

git clone https://github.com/muennich/urxvt-perls
cd urxvt-perls

cp keyboard-select ~/.urxvt/ext
cp deprecated/clipboard ~/.urxvt/ext
cp deprecated/url-select ~/.urxvt/ext

cd ..

wget -o .Xresources https://gist.githubusercontent.com/pmcfernandes/c4e6f62933f0fc24386153149f5d309e/raw/89c38d331f8cd7695f06dc9b55202dfeb7e31224/.Xresources

xrdb ~/.Xresources