#! /usr/bin/env bash

set -xe

gcc -g -Wall -c graph_adj_mat.c main.c
gcc -g -Wall -o bin/main main.o graph_adj_mat.o
rm -v *.o
./bin/main.exe | dot -Tpdf > graph.pdf
