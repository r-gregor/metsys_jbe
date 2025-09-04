#! /usr/bin/env bash

for FFF in $(find -type f -name Makefile); do sed -i -e 's:BUILD:BIN:g' -e 's:./build:./bin:g' $FFF; done
# for FFF in $(find -type f -name Makefile); do sed -i 's:/mingw6./build:/mingw6/bin:g' $FFF; done
