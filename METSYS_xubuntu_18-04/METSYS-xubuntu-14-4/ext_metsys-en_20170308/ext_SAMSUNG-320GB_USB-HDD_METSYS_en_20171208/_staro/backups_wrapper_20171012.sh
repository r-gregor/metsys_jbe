#! /bin/bash

### Name:   Scriptname ...
### Author: Author ... 
### Date:   2013-05-24 
### Decription:
### 
### 
### 

gr_run_c=METSYS/CQRB
gr_run_d=METSYS/DQRB
gr_run_a=METSYS/QRB_ALL
gr_run_h=METSYS/HQRB

read -r -d '' gr_msg <<EOF

    Usage: $0 -option[s]:
        options:
        -a  run all backups
        -c  run backups on C:\ (/c/..) - user, jome, cygwin, ...
        -d  run backups on Dropbox/{ODPRTO, SKUPNI}
        -h  run backups on H:\ (/h/..) 
EOF


if [ $# -eq 0 ]; then
    echo "$gr_msg"
    exit 1
fi

while getopts ":cdah" gr_OPT; do
    case $gr_OPT in
        a)
            # echo "Option -a: run all backups" >&2
            $gr_run_a
            break
            ;;
        c)
            # echo "option -c: run CQRB" >&2
            $gr_run_c
            ;;
        d)
            # echo "option -d: run DQRB" >&2
            $gr_run_d
            ;;
        h)
            # echo "option -h: run DQRB" >&2
            $gr_run_h
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        \?)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

