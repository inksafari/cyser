#!/usr/bin/env zsh
#
# Twenty most frequently used commands
# 
# - https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/functions.zsh
cmd_st () { 
    history | awk '{CMD[$2]++;count++;} END { for (a in CMD )print CMD[ a ]" " CMD[ a ]/count*100 "% " a }' | grep -v "./" | column -c3 -s " " -t |sort -nr | nl | head -n20
}
