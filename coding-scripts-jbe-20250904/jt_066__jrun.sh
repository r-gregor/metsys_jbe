#! /usr/bin/bash
unixpath=$1
shift
rest="$@"

java -jar $(cygpath -w $(realpath $unixpath)) $rest
