#! /bin/bash

# for num in {1..100}; do
# 
# 	if [[ $(($num % 5)) = 0 && $(($num % 3)) = 0 ]]; then
# 		echo "num ${num}: FizzBuzz"
# 	elif [[ $(($num % 3)) = 0 ]]; then
# 		echo "num ${num}: Fizz"
# 	elif [[ $(($num % 5)) = 0 ]]; then
# 		echo "num ${num}: Buzz"
# 	else
# 		echo "num ${num}: $num"
# 	fi
# done

for num in {1..100}; do

	if [[ $(($num % 5)) = 0 && $(($num % 3)) = 0 ]]; then
		printf "num %3d: FizzBuzz\n" ${num}
	elif [[ $(($num % 3)) = 0 ]]; then
		printf "num %3d: Fizz\n" ${num}
	elif [[ $(($num % 5)) = 0 ]]; then
		printf "num %3d: Buzz\n" ${num}
	else
		printf "num %3d: $num\n" ${num}
	fi
done

