#!/bin/bash

source ~/.config/dmenurc


XRANDR=$(which xrandr)

MONITORS=( $( ${XRANDR} | awk '( $2 == "connected" ){ print $1 }' ) )


NUM_MONITORS=${#MONITORS[@]}

TITLES=()
COMMANDS=()


function gen_xrandr_only()
{
    selected=$1

    cmd="xrandr --output ${MONITORS[$selected]} --auto "

    for entry in $(seq 0 $((${NUM_MONITORS}-1)))
    do
        if [ $selected != $entry ]
        then
            cmd="$cmd --output ${MONITORS[$entry]} --off"
        fi
    done

    echo $cmd
}



declare -i index=0
TILES[$index]="Cancel"
COMMANDS[$index]="true"
index+=1


for entry in $(seq 0 $((${NUM_MONITORS}-1)))
do
    TILES[$index]="Only ${MONITORS[$entry]}"
    COMMANDS[$index]=$(gen_xrandr_only $entry)
    index+=1
done

##
# Dual screen options
##
for entry_a in $(seq 0 $((${NUM_MONITORS}-1)))
do
    for entry_b in $(seq 0 $((${NUM_MONITORS}-1)))
    do
        if [ $entry_a != $entry_b ]
        then
            TILES[$index]="Dual Screen ${MONITORS[$entry_a]} -> ${MONITORS[$entry_b]}"
            COMMANDS[$index]="xrandr --output ${MONITORS[$entry_a]} --auto \
                              --output ${MONITORS[$entry_b]} --auto --left-of ${MONITORS[$entry_a]}"
            
            index+=1
        fi
    done
done


##
# Clone monitors
##
for entry_a in $(seq 0 $((${NUM_MONITORS}-1)))
do
    for entry_b in $(seq 0 $((${NUM_MONITORS}-1)))
    do
        if [ $entry_a != $entry_b ]
        then
            TILES[$index]="Clone Screen ${MONITORS[$entry_a]} -> ${MONITORS[$entry_b]}"
            COMMANDS[$index]="xrandr --output ${MONITORS[$entry_a]} --auto \
                              --output ${MONITORS[$entry_b]} --auto --same-as ${MONITORS[$entry_a]}"
            
            index+=1
        fi
    done
done


##
#  Generate entries, where first is key.
##
function gen_entries()
{
    for a in $(seq 0 $(( ${#TILES[@]} -1 )))
    do
        echo $a ${TILES[a]} 
    done
}

if [[ "$backend" == "simpleswitcher" ]]
    then function dmenu_t () {
             simpleswitcher -font "$font" -fg "$nf" -bg "$nb" -hlfg "$sf" -hlbg "$sb" -o 90 -bc "$bc" -dmenu
         }

elif [[ "$backend" == "dmenu" ]]
    then function dmenu_t () {
             dmenu -l 15 -fn "$font" -nf "$nf" -nb "$nb" -sf "$sf" -sb "$sb" -o 90
         }
fi


# Call menu
SEL=$( gen_entries | dmenu_t -p "Monitor:" | awk '{print $1}' )

# Call xrandr
$( ${COMMANDS[$SEL]} )
