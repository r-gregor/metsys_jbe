#! /usr/bin/env bash

// for FFF in $(find -type f -name Makefile); do sed -i -e 's:BIN:BUILD:g' -e 's:./bin:./build:g' $FFF; done
// for FFF in $(find -type f -name Makefile); do sed -i 's:/mingw6./build:/mingw6/bin:g' $FFF; done

for FFF in $(find -type f -name Makefile); do sed -i -e 's:BIN:BUILD:g' -e 's:./bin:./build:g' $FFF; done
for FFF in $(find -type f -name Makefile); do sed -i 's:/mingw6./build:/mingw6/bin:g' $FFF; done
