#!/bin/bash

command -v sr >/dev/null 2>&1 && command -v rofi >/dev/null 2>&1 || exit 1

# get local config
file="${XDG_CONFIG_HOME:-$HOME/.config}"/surfraw/conf
[ -f "$file" ] && [ -r "$file" ] &&
    . "$file"
default="${SURFRAW_customsearch_provider:-duckduckgo}"
# get list of search engines from surfraw
if [[ $* != *"--no-list"* ]]; then
    list="$(sr -elvi | awk '{if (NR!=1) print $1 }')"
    # for l in $list; do
    #     sr "$l" -local-help
    # done
fi
# get list of bookmarks from surfraw
if [[ $* != *"--no-bookmarks"* ]]; then
    file="${XDG_CONFIG_DIRS:-/etc/xdg}"/surfraw/bookmarks
    [ -f "$file" ] && [ -r "$file" ] &&
        list=${list:+"${list}\n"}"$(awk '{ print $1 }' "$file")"
    file="${XDG_CONFIG_HOME:-$HOME/.config}"/surfraw/bookmarks
    [ -f "$file" ] && [ -r "$file" ] &&
        list=${list:+"${list}\n"}"$(awk '{ print $1 }' "$file")"
fi
unset file

main () {
# Draw Menu
# help_color="#0C73C2"
# HELP_MSG="<span color=\"$help_color\">Hit Ctrl+Space to complete Engine Name
# Searches without prepended engine use "${default}"</span>"
# elvi=$(echo -e "$list" | rofi -dmenu -p "Search > " -mesg "${HELP_MSG}")
elvi=$(echo -e "$list" | rofi -dmenu -p "Search > ")

# Some logic
if [ -z "$elvi" ]; then exit 0
else
    engine=$(echo "$elvi" | awk '{ print $1 }')
    query=$(echo "$elvi" | awk '{$1=""; print $0}')
    if ! echo -e "$list" | grep -Fw "$engine"; then
        engine="$default"
        query="$elvi"
    fi
    sr "$engine" $query
fi
}

if [ "$1" == "--help" ]; then
    echo "rofi-surfraw - (C) 2015 Rasmus Steinke <rasi at xssn dot at>"
    echo "---"
    echo "--help         this help"
    echo "--no-list      do not show inbuilt search engines"
    echo "--no-bookmarks do not show bookmarked search engines"
else
    main
fi
