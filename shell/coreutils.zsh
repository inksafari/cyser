#!/usr/bin/env zsh
# ============================================================================
# Coreutils - GNU core utilities
# https://www.gnu.org/software/coreutils/manual/html_node/index.html
# ============================================================================

# {{{ Platform specific values
#if [[ $OSTYPE == darwin* ]]; then
#  if (( $+commands[gOOO] )) ; then              # brew install coreutils
#                   └> 前綴 g 表示 GNU 版本
#    GNU coreutils
#  elif OOO --version | grep -q coreutils; then  # brew install coreutils --with-default-names
#    GNU coreutils
#  else
#    BSD coreutils
#  fi
#elif [[ $OSTYPE" == linux* ]]; then
#  GNU coreutils
#fi

# {{{ Directory listing
#|===========================================|
#|        GNU        |        BSD            |
#|===================|=======================|
#| ls --color=auto   | ls -G or              |
#|                   | export CLICOLOR=1  or |
#|                   | export CLICOLOR==true |
#|-------------------|-----------------------|<- enable color support of GNU ls: (g)dircolors -b
#| LS_COLORS         | LSCOLORS              |
#|-------------------------------------------|
#|                   | Con: file extension   |
#|-------------------------------------------|
#|    http://geoff.greer.fm/lscolors/        | {seebi/dircolors-solarized, trapd00r/LS_COLORS}
#|===========================================|

#
# ls: List directory contents
#   - https://www.gnu.org/software/coreutils/manual/html_node/Block-size.html
#   - https://github.com/pixelb/scripts/blob/master/scripts/l
#
LS_OPTS='-v --group-directories-first --time-style="+ %Y-%m-%d %T"'
LS_GNU_OPTS='--color=auto'  # ╮ 因 "dumb" terminal 不支援 ( wiki: Computer_terminal#Dumb_terminals )，
LS_BSD_OPTS='-G'            # ╯ 請 gVim 或 Emacs 使用者多加留意。
#
# dircolors: Color setup for {ls, grep}
#
#                 ╭> dumb doesn't support colors
if [[ $TERM != 'dumb' ]]; then
  if (( $+commands[dircolors] )) ; then
    dirc=$ZSHCONF/dir_colors
    test -r $dirc && eval "$(dircolors -b $dirc)" || eval "$(dircolors -b)"
    alias grep='${aliases[grep]} --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    #https://github.com/lunaryorn/dotfiles/blob/master/zsh/.zsh.d/coreutils.zsh
    alias ls='ls $LS_OPTS $LS_GNU_OPTS'
    alias l.='ls -dbCF .[^.]?*'   # Hidden files except . and .. (currend directory only)
    alias ll='ls -lh'             # Human readable
    alias lr='ll -R'              # Human readable, recursively
    alias la='ll -A'              # Human readablem hidden files
    alias lm='la | "$PAGER"'      # Human readable, hidden files, in pager
    alias lx='ll -XB'             # By extension (GNU only).
    alias lk='ll -Sr'             # By size, largest last.
    alias lt='ll -tr'             # By date, most recent last.
    alias lc='lt -c'              # By date, most recent last, change time.
    alias lu='lt -u'              # By date, most recent last, access time.
  fi
fi

# Completion
#autoload colors
#if [ -n $LS_COLORS ]; then  # if [[ -z $LS_COLORS ]]; then
#    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#fi

# More colors: grc http://kassiopeia.juls.savba.sk/~garabik/software/grc.html
if type -f grc &> /dev/null; then
    alias colorify="grc -es --colour=auto"
    for command in df dig gcc ifconfig mount mtr netstat ping ps thraceroute; do
        if [[ -f "/usr/local/share/grc/conf.$command" ]] || [[ -f "/usr/share/grc/conf.$command" ]]; then
            alias $command="colorify $command"
        fi
    done
    for command in head tail make ld; do
        alias $command="colorify $command"
    done
fi
