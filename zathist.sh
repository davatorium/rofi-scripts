#! /bin/sh
#
# Open a PDF file in the history of the zathura viewer from rofi.
#
# Save this script as executable ~/bin/zathist.sh, install Xbindkeys
# (or Sxhkd) and, say, add to ~/.xbindkeysrc the shortcut
#
# "$HOME/bin/zathist.sh"
#   Control + Alt + z
# 
# This shell script refines https://unix.stackexchange.com/questions/467524/open-file-from-history-in-zathura

# PDFs whose path matches this pattern will not be listed
[ -z "${IGNORE_REGEX:++}" ] &&
  IGNORE_REGEX="^${TMPDIR:-/tmp}/\|_cropped\.pdf\|_optimized\.pdf$" 

[ -z "${THEME:++}" ] &&
THEME='
element{ horizontal-align: 0; }
listview {
    dynamic: true;
    padding: 0px 0px 0px ;
}'
PROMPT=${PROMPT:-'❯ '}
# uses rofi in dmenu mode; replace by dmenu itself at will

MENU_ENGINE=${MENU_ENGINE:-rofi}
MENU_ARGS="${MENU_ARGS:--dmenu -i -keep-right}"

# regex from https://github.com/lucc/config/blob/d416378290d25b9a61cd8252f7ecf98a294dd80f/rofi/bin/mru.sh#L7
selection=$(
  sed -n '/^\[.\+\]$/h;/^time=[0-9]\+$/{x;G;s/^\[\(.\+\)\]\ntime=\([0-9]\+\)$/\2 \1/p}' "${XDG_DATA_HOME:-$HOME/.local/share}/zathura/history" |
    sort -nr | cut -d ' ' -f 2- |
    grep -v "$IGNORE_REGEX" |
    while IFS= read -r f; do [ -f "$f" ] && echo "$f"; done |
    sed "s#^${HOME}/#~/#" |
    ${MENU_ENGINE} ${MENU_ARGS} -theme-str "$THEME" -p "$PROMPT" |
    sed "s#^~/#${HOME}/#"
)
[ -r "$selection" ] || exit
nohup zathura "$selection" </dev/null >/dev/null 2>&1 &
