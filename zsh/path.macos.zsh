#!/usr/bin/env zsh

#
# Homebrew
#
export ARCHFLAGS="-arch x86_64"
export HOMEBREW_NO_ANALYTICS=1

#
# Cask
#
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

#
# GNU coreutils
#
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"

#
# MacTeX / BasicTeX
#
#export TEXBIN=
#export PATH=$TEXBIN:$PATH
