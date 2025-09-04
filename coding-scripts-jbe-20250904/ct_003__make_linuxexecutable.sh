#! /usr/bin/env bash


usage() {
cat << "EOF"
	Usage:
	make_[win|linux]executable.sh <filename without end>

EOF
exit 1
}

if [ $# -ne 1 ]; then
	usage
fi

fname=$1

gcc "${fname}".c -o linuxexecutables/"${fname}"

