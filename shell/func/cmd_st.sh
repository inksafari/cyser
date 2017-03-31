#!/usr/bin/env zsh
#
# Twenty most frequently used commands
# 
# - https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/functions.zsh
# - https://github.com/naps62/dotfiles/blob/master/config/zsh/cmds.zsh
cmd_st () { 
  history | awk '{
      CMD[$2]++; count++;
      }
    END {
      for (i in CMD) print CMD[i]/count*100 "%", i
    }' | sort -nr | head -n20 | column -c3 -s " " -t
}
