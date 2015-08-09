#!/bin/bash -x

if [[ -z $@ ]]
then
showList () {
    tmux lsp -aF'#{session_name}:#{window_index}.#{pane_index}+#{window_name}+#{pane_current_command}+"#{pane_title}"' | column -t -s '+' -o '  '
}
echo "$(showList)"

else
    _windowlist="$@"
    _windowindex=$(echo "${_windowlist}" | awk -F '  ' '{ print $1 }' | awk -F ':' '{ print $2 }' | awk -F '.' '{ print $1 }')
    _paneindex=$(echo "${_windowlist}" | awk -F '  ' '{ print $1 }' | awk -F ':' '{ print $2 }' | awk -F '.' '{ print $2 }')
    _windowname=$(echo "${_windowlist}" | awk -F '  ' '{ print $2 }')
    _appname=$(echo "${_windowlist}" | awk -F '  ' '{ print $3+NF}')
    _sessionname=$(echo "${_windowlist}" | awk -F '  ' '{ print $1 }' | awk -F ':' '{ print $1 }')

    if [[ -n "${_windowlist}" ]]
    then
        tmux select-window -t "${_sessionname}:${_windowindex}" 
        WID=$(xdotool search --name "tmux - " | tail -1)
        xdotool windowactivate --sync $WID
        killall rofi
    fi
fi

