#! /usr/bin/env bash
# filename: array-to-function-test.sh
# 20260304 mdb v1
# last 20260304
# ---

list1=(
"Gregor Redelonghi"
"Tadeja Mali Redelonghi"
"Zala Redelonghi"
"Mark Redelonghi"
"Špela Redelonghi"
"Sisi (Jelka)"
)

# option 1
# parameter as dereference of $1
# argument must be a string: "arrayname[@]"
print_array() {
	local my_list=("${!1}")
	for PRS in "${my_list[@]}"; do
		printf "%s\n" "${PRS}"
	done
}

# option 1
# parameter as dereference of $1
# argument must be a string: "arrayname[@]"
print_array_idx() {
	local my_list=("${!1}")
	for ((i = 0; i < ((${#my_list[@]} - 1)); i++)); do
		printf "%02d %s\n" $(($i + 1)) "${my_list[$i]}"
	done
}

# option 2
# parameter is just a positional parameter (bash >= 4.3)
# argument is just an arrayname
print_array_n() {
	local -n my_list=$1
	for ((i = 0; i < ((${#my_list[@]} - 1)); i++)); do
		printf "%02d %s\n" $(($i + 1)) "${my_list[$i]}"
	done
}

# main
print_array "list1[@]"
echo "---"
print_array_idx "list1[@]"
echo "---"
print_array_n list1
echo "---"

