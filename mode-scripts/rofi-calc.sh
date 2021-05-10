#!/usr/bin/env bash

# A rofi mode script that allows calculations to be done
# by Adnan Shameem (adnan360). License: MIT (Expat)
#
# Usage:
# - Download this into a dir
# - Make sure it's executable: chmod +x rofi-calc.sh
# - Make sure you have at least one of these:
#     - bc
#     - python (v2 or v3)
#     - bcalc (curl -LO https://github.com/Phate6660/bcalc/blob/master/bcalc && chmod +x bcalc)
# - Run: rofi -modi "calc:./rofi-calc.sh" -show calc
#   or, use this to have both run and calc options: rofi -combi-modi "calc:./rofi-calc.sh",run -show combi
# - Enter expressions like "2+2", "15-5", "10*2", "3^2" to get results

# Handle input
# Important! It has to be before anything else is done in the script.
# Otherwise it will keep reopening the menu indefinitely!
if [ ! -z "$@" ]; then
	# To strip spaces
	input=$(echo "$@" | sed 's/[[:space:]]*//g')
	# If input has numbers and symbols, process it
	if grep -q '+\|-[[:digit:]]\|\*\|\/\|\^' <<<"$input"; then
		if [ ! -z "$(command -v bc)" ]; then # has bc package on system
			# If there is an equal sign (=) at the end, get rid of it.
			input=$(echo "$input" | sed 's/\=//g')
			# Show the result in a notification.
			echo "$input = "$( echo $input | bc )
		elif [ ! -z "$(command -v python)" ]; then # has python package on system
			# If there is an equal sign (=) at the end, get rid of it.
			# Replace "^" with "**" so that it can calculate powers.
			input=$(echo "$input" | sed 's/\=//g;s/\^/**/g')
			# Show the result in a notification.
			# The "float(1)*" part is so that Python 2 returns decimal places.
			echo "$input = "$( python -c "print( float(1)*$input )" )
		elif [ -f "$(dirname $0)/bcalc" ]; then # has bcalc
			# If there is an equal sign (=) at the end, get rid of it.
			input=$(echo "$input" | sed 's/\=//g')
			echo "$input = "$($(dirname $0)/bcalc "$input")
		else
			echo 'Error: No calculation utility found.'
			echo 'Please install bc, python or bcalc.'
		fi
	fi
    exit 0
fi

# Change prompt
echo -en "\0prompt\x1fcalc\n"
