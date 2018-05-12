#!/bin/bash
#
# Allows to manage screens with rofi using implicitly xrandr.

MONITORS=($($(which xrandr) | awk '($2 == "connected"){print $1}'))
NUM_MONITORS=${#MONITORS[@]}

declare -i index=0
TILES[$index]="Cancel"
index+=1

# Turn off monitors except a specified one.
function disable_monitors_except() {
    cmd="xrandr --output ${MONITORS[$1]} --auto"

    for i in $(seq 0 $((${NUM_MONITORS} - 1)))
    do
	if [ $1 != $i ]; then
	    echo "$cmd --output ${MONITORS[$i]} --off"
	    return
	fi
    done

    echo $cmd
}

# Generate entries.
function gen_entries() {
    for i in $(seq 0 $((${#TILES[@]} - 1)))
    do
	echo "$i: ${TILES[i]}"
    done
}

# Generate monitor options according to a valid mode.
# Available modes are: "only", "clone" and "dual".
function gen_options() {
    if [ "$1" == "only" ]; then
	for i in $(seq 0 $((${NUM_MONITORS} - 1)))
	do
	    TILES[$index]="Only ${MONITORS[$i]}"
	    COMMANDS[$index]=$(disable_monitors_except $i)
	    index+=1
	done
    else
	for i in $(seq 0 $((${NUM_MONITORS} - 1)))
	do
	    for j in $(seq 0 $((${NUM_MONITORS} - 1)))
	    do
		if [ $i != $j ]; then
		    if [ "$1" == "clone" ]; then
			TILES[$index]="Clone Screen ${MONITORS[$i]}  ${MONITORS[$j]}"
			COMMANDS[$index]="xrandr --output ${MONITORS[$i]} --auto \
                              --output ${MONITORS[$j]} --auto --same-as ${MONITORS[$i]}"
		    elif [ "$1" == "dual" ]; then
			TILES[$index]="Dual Screen ${MONITORS[$i]}  ${MONITORS[$j]}"
			COMMANDS[$index]="xrandr --output ${MONITORS[$i]} --auto \
                              --output ${MONITORS[$j]} --auto \
			       --right-of ${MONITORS[$i]}"
		    fi
		    index+=1
		fi
	    done
	done
    fi
}

gen_options 'only'
gen_options 'dual'
gen_options 'clone'

# Call menu
SEL=$(gen_entries | rofi -dmenu -p "Monitor Setup" -no-custom  | awk '{print $1}')

# Call xrandr
$(${COMMANDS[${SEL::-1}]})
