#! /bin/bash


if [ $# -ne 1 ]; then
    echo "Usage: RENAME_20191025.sh [prefix: java=j, python=p, go=g]"
    exit 1
fi

prfx=$1


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
    
    nm1=$(echo ${line} | sed "s/\(${prfx}...*_\)\(.*\)/\2/")
    
    nm2="${prfx}${ozn}_${nm1}"
    
    # test
    # echo "Renaming ${line} --> to --> ${nm2}"
    
    printf "%-66s%s\n" "Renaming ${line}" "to: ${nm2}"
    
    let i=i+1
done <seznam2



# ACTION
read -p "Continue?"
    
j=1
while read line; do
    if [ $j -lt 100 -a $j -ge 10 ]; then
        ozn="0${j}"

    elif [ $j -lt 10 ]; then
        ozn="00${j}"
    
    else
        ozn=$j
    fi
    
    nm1=$(echo ${line} | sed "s/\(${prfx}...*_\)\(.*\)/\2/")
    
    nm2="${prfx}${ozn}_${nm1}"

    mv -v ${line} ${nm2}
    
    let j=j+1
done <seznam2
