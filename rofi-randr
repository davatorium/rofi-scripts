#!/usr/bin/zsh
#
# Setup outputs with xrandr as a backend and dmenu as a frontend
#
# external commands: cat, cut, dmenu, grep, sed, xrandr
# Released under GPLv2

typeset XRANDR_TXT # readonly; stdout of running xrandr without any options
typeset -A OUTPUT_CONFIGURED # key=connected output name

function main() {
  local -i iteration
  local max_iteration
  local output
  local mode
  local position
  local xrandr_cmd

  environment_check

  max_iteration=${(w)#OUTPUT_CONFIGURED}
  xrandr_cmd='xrandr'

  while ! all_outputs_configured && (( $iteration <= $max_iteration )); do
    if (( iteration++ )); then
      select_output 'Select next output:' 'unconfigured' | read output
      select_position "${output}" | read position
      [[ "${position}" != '--off' ]] && select_mode "${output}" | read mode
      OUTPUT_CONFIGURED[${output}]='true'
    else
      select_output 'Select primary output:' 'all' | read output
      select_mode "${output}" | read mode
      OUTPUT_CONFIGURED[${output}]='true'
      position='--primary'
    fi
    xrandr_cmd+=" --output ${output} ${position} ${mode}"
  done

  ${=xrandr_cmd}
}

################################################################################
# Uses dmenu to select an output. Skips menu if only 1 option is available.
# Prints the name of the selected output to stdout
# Global variables:
#  OUTPUT_CONFIGURED
# Arguments:
#  $1=prompt
#  $2=group of outputs. valid options are configured, unconfigured, all
# Returns:
#  257=bad arguments
#  258=bad selection (TODO)
#  259=no options available
################################################################################
function select_output() {
  local -a menu
  local output
  local -ir err_bad_args=257
  local -ir err_bad_selection=258
  local -ir err_no_options=259

  case "$2" in
    'configured')
      for output in ${(k)OUTPUT_CONFIGURED}; do
        ${OUTPUT_CONFIGURED[$output]} && menu+=("$output")
      done
      ;;
    'unconfigured')
      for output in ${(k)OUTPUT_CONFIGURED}; do
        ${OUTPUT_CONFIGURED[$output]} || menu+=("$output")
      done
      ;;
    'all') menu=(${(k)OUTPUT_CONFIGURED}) ;;
    *) return "${err_bad_args}" ;;
  esac

  case ${#menu} in
    0) return "${err_no_options}" ;;
    1) echo "${menu}" ;;
    *) echo ${(F)menu} | rofi -dmenu -l 10 -p "$1" ;;
  esac
}

################################################################################
# Uses dmenu to select the position of a given output relative to an already
# configured output. --same-as and --off are considered a position.
# Prints in the form of xrandr option (eg, '--right-of DP1') to stdout
# Global variables:
#  OUTPUT_CONFIGURED
# Arguments:
#  $1=name of output to configure
# Returns:
#  257=bad argument (TODO: check validity beyond existance)
#  258=bad selection
#  259=no configured outputs to relate to (ie, no anchor)
################################################################################
function select_position() {
  local anchor
  local selection
  local -ir err_bad_arg=257
  local -ir err_bad_selection=258
  local -ir err_no_anchor=259

  [[ -z $1 ]] && return "${err_bad_arg}"

  select_output "Set $1 relative to:" 'configured' | read anchor
  [[ $? -eq 257 ]] && return "${err_no_anchor}"

  echo "left of ${anchor}
right of ${anchor}
above ${anchor}
below ${anchor}
mirror ${anchor}
off" | rofi -dmenu -l 10 -p "Select position of $1:" | read selection

  case "${selection[(w)1]}" in
    left) echo "--left-of ${anchor}" ;;
    right) echo "--right-of ${anchor}" ;;
    above) echo "--above ${anchor}" ;;
    below) echo "--below ${anchor}" ;;
    mirror) echo "--same-as ${anchor}" ;;
    off) echo "--off" ;;
    *) return "${err_bad_selection}" ;;
  esac
}

################################################################################
# Uses dmenu to display the detected mode options for a given output and lets
# the user select a mode to use. Prints choice in xrandr option format
# (eg, '--mode 800x600' or '--auto') to stdout
# Global variables:
#  XRANDR_TXT
#  CONNECTED_OUTPUT
#  XRANDR_CMD (via primary_set())
# Arguments:
#  $1 - name of which output we are working with
# Returns:
#  257=bad arguements; given output ($1) not found/connected (TODO)
#  258=bad selection
################################################################################
function select_mode() {
  local menu
  local selection
  local -ir err_bad_args=257
  local -ir err_bad_selection=258

  if [[ -z $1 ]] && return "${err_bad_args}"

  # TODO: make this not ugly. A better sed should negate the need for cut/grep
  # Should probably parse (sed) seperately then assign to the array. Or not
  # use an array at all.
  menu="$(echo \"${XRANDR_TXT}\" \
    | sed -n '/^'$1' /,/^[^ ]/ s/ * //p' \
    | cut -d ' ' -f 1 \
    | grep x \
    | cat <(echo auto) -)"

  echo "${menu}" | rofi -dmenu -l 10 -p "Select mode for $1:" | read selection

  case "${selection}" in
    'auto') echo '--auto' ;;
    *x*) echo "--mode ${selection}" ;;
    *) return "${err_bad_selection}" ;;
  esac
}

################################################################################
# Checks to see if all the outputs have been configured
# global variables:
#  OUTPUT_CONFIGURED
# Arguments:
#  none
# Returns:
#  0 - all outputs are configured
#  257 - at least 1 output not configured
################################################################################
function all_outputs_configured() {
  local config

  for config in ${OUTPUT_CONFIGURED}; do
    $config || return 257
  done

  return 0
}

function environment_check() {
  if ! command -v cat &>/dev/null; then
    echo 'You seem to be missing coreutils. You'\''re gonna have a bad time.' >&2
    exit 255
  elif ! command -v grep &>/dev/null; then
    echo 'grep seems to be missing. You'\''re gonna have a bad time.' >&2
    exit 255
  elif ! command -v xrandr &>/dev/null; then
    echo "Try xrandr-dmenu without xrandr, and you're gonna have a bad time." >&2
    exit 255
elif ! command -v rofi &>/dev/null; then
    echo "Try xrandr-dmenu without dmenu, and you're gonna have a bad time." >&2
    exit 255
  elif ! xset q &>/dev/null; then
    echo 'Woah there, cowboy! You need to run this from inside X!' >&2
    exit 1
  fi
}

function initialize_globals() {
  local output

  XRANDR_TXT="$(xrandr)"
  for output in $(grep ' connected' <<< "${XRANDR_TXT}" | cut -d ' ' -f 1); do
    OUTPUT_CONFIGURED[${output}]='false'
  done
}

initialize_globals
readonly XRANDR_TXT
main

################################################################################
# vim filetype=zsh autoindent expandtab shiftwidth=2 tabstop=2
# End
#
