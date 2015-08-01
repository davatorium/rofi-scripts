#!/bin/bash

###########################################################
# script done by cornerman (https://github.com/cornerman) #
###########################################################

declare -i index=0
while read -r window; do
    pid=$(echo "$window" | awk '{print $3}')
    program=$(ps -p "$pid" -o comm=)
    IDS[$index]=$(echo "$window" | awk '{print $1}')
    TITLES[$index]="$program: $(echo "$window" | awk '{for (i=5; i<=NF; i++) print $i}')"
    index+=1
done <<< "$(wmctrl -l -p)"

function gen_entries()
{
    for a in $(seq 0 $(( ${#TITLES[@]} -1 )))
    do
        echo ${TITLES[a]}
    done
}

selections=$( gen_entries | rofi -dmenu -p "Window: " -format i )
[ "$selections" = "" ] && exit

while read -r selection; do
    if [ "$selection" != -1 ]; then
        window_id=$(printf "%d" "${IDS[selection]}")
        i3-msg "[ id = $window_id ] move workspace current, focus" > /dev/null
    fi
done <<< "$selections"
