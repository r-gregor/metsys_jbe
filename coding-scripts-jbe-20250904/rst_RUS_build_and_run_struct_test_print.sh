#! /usr/bin/env bash
#  build_and_run_struct_test_print.sh

_dst="./majbin/struct_test_print"
_src="./src/struct_test_print.rs"
mcmd="./majbin/struct_test_print"

echo -n "[INFO] compiling ${_src} into ${_dst} ..."
rustc -o ${_dst} ${_src}
echo " [OK]"
echo "---"
${mcmd}


