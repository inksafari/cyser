#!/usr/bin/env zsh
# https://github.com/kui/dotfiles/blob/master/dotfiles/zshrc

#       ╭> CLI
# Homebrew ( Cask )
#              ╰> GUI
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

#
# GNU coreutils
#
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"

#
# MacTeX / BasicTeX
#
#export TEXBIN="/Library/TeX/texbin"
#export PATH=$TEXBIN:$PATH

#
# Paths
#
typeset -gU cdpath fpath mailpath path

path=(
  ~/bin
  /usr/local/share/npm/bin
  /usr/local/heroku/bin
  /usr/local/{bin,sbin}
  $path
)
