#! /usr/bin/env bash

function tmux_sessions()
{
    # Get all existing sessions
    tmux list-session -F '#S'|cut -d'-' -f 1
}
# Take the choice of session in TMUX_SESSION
TMUX_SESSION=$( (tmux_sessions; echo "New") | rofi -dmenu -p "Select existing tmux session")

if [[ x"New" = x"${TMUX_SESSION}" ]]; then
    # Ask for name of session
    NAME=$(rofi -dmenu -p "Name for new session")
    rofi-sensible-terminal -e tmux new-session -t "${NAME}" &
elif [[ -z "${TMUX_SESSION}" ]]; then
    echo "Cancel"
else
    if tmux_sessions | grep -q '${TMUX_SESSION}'; then
	rofi-sensible-terminal -e tmux attach -t ${TMUX_SESSION} &
    else 
	rofi-sensible-terminal -e tmux new -t ${TMUX_SESSION} &
    fi
fi
