#! /bin/bash

if [ $# == 1 ]; then
	unixpath=$1
else
	unixpath="."
fi

# win
java -jar $(cygpath -w $HOME/majstaf/java/jars/RsortByEnddate.jar) $(cygpath -w $unixpath)


#linux
# java -jar $(dirname ${BASH_SOURCE[0]})/jars/RsortByEnddate.jar $unixpath
