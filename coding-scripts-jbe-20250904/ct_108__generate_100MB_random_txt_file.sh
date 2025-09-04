#! /usr/bin/env bash

tr -dc "A-Za-z 0-9" < /dev/urandom | fold -w100|head -n $((1000*1024)) > big_100MB_file.txt
# tr -dc "A-Za-z 0-9" < /dev/urandom | fold -w100|head -n $((500*1024)) > big_50MB_file.txt
# yes this is test file | head -c 100MB > test_file_100MB.txt
# yes this is test file | head -c $((100*1024*1024)) > test_file_100MiB.txt
