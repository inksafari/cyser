#!/usr/bin/env zsh
# ----------------------------------------------------------------------
# Better History
# ----------------------------------------------------------------------
# permissions
#umask 022                      # files:644 / dirs:755

#
# Variables
#
if [ -z "$HISTFILE" ]; then
    HISTFILE=$ZSHCONF/logs/zsh-history
fi

HISTSIZE=10000                  # History size in memory
SAVEHIST=50000                  # The number of histsize
LISTMAX=50                      # The size of asking history
KEYTIMEOUT=20                   # Reduce delay after you hit the <ESC> to 0.2 seconds

# Do not add in root
if [[ $UID == 0 ]]; then
    unset HISTFILE
    export SAVEHIST=0
fi

case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac


#
# Options
#
setopt append_history           # instead of replace, when a terminal session exits
setopt bang_hist                # !keyword ( like csh and bash )
setopt extended_history         # record start and end time to history file
setopt hist_expire_dups_first   # expire a duplicate event first when trimming history
setopt hist_ignore_dups         # don’t record an event that was just recorded again
#setopt hist_ignore_all_dups    # delete an old recorded event if a new event is a duplicate
setopt hist_save_no_dups        # don’t write a duplicate event to the history file
#setopt hist_ignore_space       # don’t store lines starting with spaces
setopt hist_reduce_blanks       # trim extra blanks
setopt hist_verify              # show before executing history commands
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit 
setopt share_history            # share hist between sessions

