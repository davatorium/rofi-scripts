#!/usr/bin/env bash

# A rofi mode script that allows bash aliases to be run
# by Adnan Shameem. License: MIT (Expat)
#
# Usage:
# - Download this into a dir
# - Make sure it's executable: chmod +x rofi-aliases.sh
# - Make sure you have $TERMINAL set or change the "TERMINAL=" line below
# - Run: rofi -modi "aliases:./rofi-aliases.sh" -show aliases
#   or, use this to include both run and alias options: rofi -combi-modi run,"aliases:./rofi-aliases.sh" -show combi

# Handle input
# Important! It has to be before anything else is done in the script.
# Otherwise it will keep reopening the menu indefinitely!
if [ ! -z "$@" ]; then
	if [ -z "$TERMINAL" ]; then
		# Fallback if $TERMINAL is not set
		# Set this to anything you like
		TERMINAL="lxterminal"
	fi
	$TERMINAL -e "echo \"Running alias '$@'...\"; bash -i -c \"$@\"; echo \"Press Ctrl+D to exit this terminal...\"; read"
    exit 0
fi

# Change prompt
echo -en "\0prompt\x1falias\n"

# For alias call to work
shopt -s expand_aliases
test -f $HOME/.bash_aliases && source $HOME/.bash_aliases

# List alias entries
alias | awk -F '=' '{print $1}' | grep '^alias ' | awk '{print $2}'
