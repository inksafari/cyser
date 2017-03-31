#!/usr/bin/env zsh

#
# Processes
#

# lists zombie processes
function zombie() {
  ps aux | awk '{if ($8=="Z") { print $2 }}'
}

# Show how much RAM application uses.
# from https://github.com/paulmillr/dotfiles
# usage: ram safari
function ram() {
  local sum
  local items
  local app="$1"
  if [[ -z "$app" ]]; then
    echo "First argument - pattern to grep from processes"
  else
    sum=0
    for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
      sum=$(($i + $sum))
    done
    sum=$(echo "scale=2; $sum / 1024.0" | bc)
    if [[ $sum != "0" ]]; then
      echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
    else
      echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
    fi
  fi
}

# search for running processes
# from http://onethingwell.org/post/14669173541/any
any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any " >&2 ; return 1
    else
        ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
    fi
}
