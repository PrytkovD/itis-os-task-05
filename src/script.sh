#!/bin/bash

declare -i step=1
declare -i correct_guesses=0
declare -i incorrect_quesses=0
last_ten_guesses=()

RED='\e[31m'
GREEN='\e[32m'
RESET='\e[0m'

while true; do
	number=$((RANDOM % 10))

	echo "Step: $step"
	read -p "Please enter number from 0 to 9 (q - quit): " guess

	if [[ "$guess" == "q" ]]; then
		break
	fi

	if ! [[ "$guess" =~ ^[0-9]$ ]]; then
		echo "Invalid input. Please enter a number from 0 to 9 or q to quit"
		continue
	fi

	guess=$((guess))

	if [[ $guess -eq $number ]]; then
		((correct_guesses++))
		echo "Hit! My number: $number"
		last_ten_guesses+=("${GREEN}$guess${RESET}")
	else
		((incorrect_guesses++))
		echo "Miss! My number: $number"
		last_ten_guesses+=("${RED}$guess${RESET}")
	fi

	if [[ ${#last_ten_guesses[@]} -gt 10 ]]; then
		last_ten_guesses=("${last_ten_guesses[@]:1}")
	fi

	total_guesses=$((correct_guesses + incorrect_guesses))

	echo "Hit: $(bc -l <<< "scale=2; $correct_guesses / $total_guesses * 100")% Miss: $(bc -l <<< "scale=2; $incorrect_guesses / $total_guesses * 100")%"
	echo -e "Numbers: ${last_ten_guesses[@]}"

	((step++))
done
