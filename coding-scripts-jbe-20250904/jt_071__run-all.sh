#! /usr/bin/env bash

for i in 1 2 3 4; do java -cp out depinjection${i}.MainApp${i}; done

