#! /usr/bin/env bash

# PTH=$(cygpath -w $(dirname $(realpath $0)))
PTH=$PWD
# test
# echo "Path: $PTH"

echo
echo "*** Running: SortedArray ***"
java -cp $PTH/classes sortedarray.SortedArray

echo
echo "*** Running: SortedSetOfArray ***"
java -cp $PTH/classes sortedtreeset.SortedSetOfArray
