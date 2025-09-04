#! /usr/bin/env bash

curdir="$(dirname $0)"
if [ $curdir = "." ]
then
    ./minjre/bin/java -jar MainApp.jar
else
    cd ./$curdir
    ./minjre/bin/java -jar MainApp.jar
fi
