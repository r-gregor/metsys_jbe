#! /usr/bin/env bash

for FFF in $(find * -type f -name "*.c"); do if ! grep -q "return 0" $FFF; then echo "$FFF"; fi; done

