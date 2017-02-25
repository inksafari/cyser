#!/usr/bin/env zsh

#
# Processes
#

# lists zombie processes
function zombie() {
  ps aux | awk '{if ($8=="Z") { print $2 }}'
}
