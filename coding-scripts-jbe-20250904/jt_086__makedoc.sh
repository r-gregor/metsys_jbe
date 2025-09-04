#! /usr/bin/env bash

docdir="javadoc"

if [ ! -d ${docdir} ]; then
    echo "No ${docdir} found. creating ..."
	mkdir -p ${docdir}
else
    echo "${docdir} found. OK"

fi

if [ -z "$(ls -A ${docdir})" ]; then
    echo "${docdir} empty. OK"
else
    echo -n "${docdir} NOT empty! Emtying ... "
    count=0
	for FFF in $(find ${docdir}/ -type f); do
        rm $FFF 2> /dev/null
        let count=count+1
    done
    echo "$count files removed."
fi

javadoc -d javadoc/ -private src/listtest/*