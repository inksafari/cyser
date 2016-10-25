#!/usr/bin/env zsh
# - https://github.com/EvanPurkhiser/dots-personal/blob/master/base/bash/environment

# ----------------------------------------------------------------------
# GUI Tools
# ----------------------------------------------------------------------
#
# IME
#
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# ----------------------------------------------------------------------
# Writing/Typesetting Tools
# ----------------------------------------------------------------------
#
# TeX ( TeX Live 2016 )
#
#export PATH=/usr/local/texlive/2016/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2016/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2016/texmf-dist/doc/info:$INFOPATH

# ----------------------------------------------------------------------
# Programming Languages & Packages Managers
# ----------------------------------------------------------------------
#
# Linuxbrew
#
#export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH=$HOME/.linuxbrew/share/man:$MANPATH
export INFOPATH=$HOME/.linuxbrew/share/info:$INFOPATH
export XDG_DATA_DIRS=$HOME/.linuxbrew/share:$XDG_DATA_DIRS

#
# Golang ( https://golang.org/dl/ )
#
# check: `go env`
export GOROOT=$XDG_DATA_HOME/golang/go                    # ~/.local/share/golang/go
export GOPATH=$HOME/.local/lib/go
#export GOARCH=amd64
#export GOOS=${$(uname -s):l}

#
# Node.js & npm ( NodeSource repo )
#
# https://github.com/npm/npm/issues/6675
# see `npm config ls -l | grep /`
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config  # npmrc
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_TMP=$XDG_RUNTIME_DIR/npm

#
# Python
#
export PIP_DOWNLOAD_CACHE=$XDG_CACHE_HOME/pip/cache
export PIP_USE_MIRRORS=true
export PYTHONDONTWRITEBYTECODE=true
#export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/config.py
export VIRTUALENV_DISTRIBUTE=true

#
# Ruby ( apt install ruby2.3 ruby2.3-dev )
#
## $HOME/.gem/ruby/2.3.0
#GEM_HOME=$(ls -t -U | ruby -e 'puts Gem.user_dir')
#GEM_PATH=$GEM_HOME
#export PATH=$GEM_HOME/bin:$PATH

## ~/.local/share/gem/ruby/2.3.0
export RUBY_VERSION=2.3.0
export GEM_HOME=$HOME/.local/lib/gem/ruby/$RUBY_VERSION
export GEM_PATH=$GEM_HOME
export GEMRC=$XDG_CONFIG_HOME/gem/config
export GEM_SPEC_CACHE=$XDG_CACHE_HOME/gem/specs

## REPL
export IRBRC=$XDG_CONFIG_HOME/ruby/irbrc
export PRYRC=$XDG_CONFIG_HOME/ruby/pryrc

## Static Code Analyzer ( .rubocop.yml )
## Debugging ( .byebugrc or .rdebugrc )

#
# Rust ( curl -sSf https://static.rust-lang.org/rustup.sh | sh )
#
export CARGO_HOME=~/.cargo
#export PATH=$CARGO_HOME/bin:$PATH
export RUST_NEW_ERROR_FORMAT=true

#
# SQL
#
#export MYSQL_HISTFILE=$XDG_DATA_HOME/mysql_history

# ----------------------------------------------------------------------
# CLI Tools
# ----------------------------------------------------------------------
# rg ( ripgrep -> https://github.com/BurntSushi/ripgrep/ )
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# ----------------------------------------------------------------------
# Paths
# ----------------------------------------------------------------------
# -U for Unique, like a set
typeset -gx -U cdpath fpath path PATH

#
# for `cd` command
#
cdpath+=(
  $HOME/.own                                  # my personal config files
  $XDG_CONFIG_HOME                            # ~/.config
)

#
# functions
#
fpath+=(
  /usr/local/share/zsh/site-functions
  $ZPLUG_REPOS/zsh-completions/src            # zsh-users/zsh-completions repo
  $ZSHCONF/func                               # custom zsh functions
  $ZSHCONF/comp                               # custom zsh completions
)

#
# programs ( check: `echo $PATH` )
#
# https://github.com/lunaryorn/dotfiles/blob/master/zsh/.zprofile
# (N) -> only if exists
PATH+=(
  /opt/texbin                                 # TeX
  /usr/local/texlive/2016/bin/x86_64-linux    # TeX
  /usr/share/doc/git/contrib/diff-highlight   # Git diff-highlight
  $HOME/bin                                   # Personal executables
  $HOME/.local/bin                            # Local executables from Python
  ${PYTHONUSERBASE:-$HOME/.local}/bin         # Local Python packages
  $HOME/anaconda3/bin                         # Anaconda for py3
  $HOME/.local/share/umake/bin                # Ubuntu Make
  $HOME/.linuxbrew/bin                        # Linuxbrew
  $HOME/.yarn/bin                             # Yarn ( NPM alternative )
  #$HOME/.gem/ruby/*/bin(N)                   # Local Ruby packages ( or $(ruby -e 'print Gem.user_dir')/bin )
  $GEM_HOME/bin                               # Local Ruby packages
  $CARGO_HOME/bin                             # Local Rust packages
  $GOROOT/bin                                 # Golang
  $GOPATH/bin                                 # Local Go packages
  $XDG_DATA_HOME/node/bin                     # Local Node.js packages ( NPM: npmrc )
)
export PATH
