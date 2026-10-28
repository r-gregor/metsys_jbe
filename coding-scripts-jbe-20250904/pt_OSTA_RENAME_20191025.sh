#! /bin/bash


if [ $# -ne 1 ]; then
    echo "Usage: RENAME_20191025.sh [prefix: java=j, python=p, go=g]"
    exit 1
fi

prfx=$1

touch seznam.txt
> seznam.txt

find -maxdepth 1 -type d -iname "201*" > seznam.txt


# TEST
i=1
while read line; do
    if [ $i -lt 100 -a $i -ge 10 ]; then
        ozn="0${i}"

    elif [ $i -lt 10 ]; then
        ozn="00${i}"
    
    else
        ozn=$i
    fi
    
    nm1="${prfx}${ozn}_${line}"
    
    nm2=$(echo ${nm1} | sed 's/\(.*\)_\.\/\([[:digit:]]\{8\}\)\(.*\)/\1\3_\2/')
    
    # test
    # echo "Renaming ${line} --> to --> ${nm2}"
    printf "%-66s%s\n" "Renaming ${line}" "to: ${nm2}"
    
    let i=i+1
done <seznam.txt



# ACTION
read -p "Continue?"
    
j=1
while read line; do
    if [ $j -lt 100 -a $j -ge 10 ]; then
        ozn="0${i}"

    elif [ $j -lt 10 ]; then
        ozn="00${j}"
    
    else
        ozn=$j
    fi
    
    nm1="${prfx}${ozn}_${line}"
    
    nm2=$(echo ${nm1} | sed 's/\(.*\)_\.\/\([[:digit:]]\{8\}\)\(.*\)/\1\3_\2/')

    mv -v ${line} ${nm2}
    
    let j=j+1
done <seznam.txt
