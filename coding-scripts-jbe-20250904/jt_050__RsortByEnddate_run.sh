#! /bin/bash

if [ $# != 2 ]; then
	unixpath=$1
else
	unixpath="."
fi

# win
# java -jar $(cygpath -w $(realpath $unixpath)) $rest

# linux

java -jar RsortByEnddate.jar $unixpath

