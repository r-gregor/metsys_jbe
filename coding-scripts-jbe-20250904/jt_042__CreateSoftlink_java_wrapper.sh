#! /bin/bash

# test if filename supplied as argument
if [ ! $# -eq 1 ]; then
    echo "Usage:"
    echo "$0 [filename]"
    echo
    exit
fi

# DST=$(cygpath -w $(realpath $1))
DST=$(cygpath -w $1)

# test if filename exists
if [ ! -e ${DST} ]; then
    echo "file: ${DST} NOT found!"
    exit
fi


# TEST
# DST=$(cygpath -w $(realpath /c/Users/gregor.redelonghi/majstaf/BRISI/TESTFILE_20190205))

PTH=~/majstaf/coding/JAVA_en/JAVA_en_testing/20190204_create_softlink_run_shell_command/
CMD="java -cp $(cygpath -w $(realpath ${PTH})) CreateSoftlink_en ${DST}"


$CMD
