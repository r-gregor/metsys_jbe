#! /usr/bin/env bash

CMD=bin/isprimefuncwithargument.exe
for N in $(seq 3 2 51); do ${CMD} $N; done

