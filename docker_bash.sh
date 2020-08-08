#! /bin/bash

CONTAINER=$(docker ps | tail -n +2 | rofi -dmenu -p 'Select container' | cut -d ' ' -f 1)

if [[ -z "$CONTAINER" ]]; then
  echo 'Cancel'
else
  rofi-sensible-terminal -e "docker exec -ti $CONTAINER /bin/bash" &
fi
