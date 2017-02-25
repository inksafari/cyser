#!/usr/bin/env zsh
# - https://github.com/EvanPurkhiser/dots-personal/blob/master/base/bash/environment

# ----------------------------------------------------------------------
# GUI Tools
# ----------------------------------------------------------------------
#
# IME
#
if (( $+commands[ibus-daemon] )); then
  export GTK_IM_MODULE=ibus
  export QT_IM_MODULE=ibus
  export XMODIFIERS=@im=ibus
fi

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
# Nix ( site: https://nixos.org/nix/ )
#
## https://github.com/LnL7/dotfiles/blob/master/zshrc.exports
export NIX_LINK=$HOME/.nix-profile
export NIX_EXPR=$HOME/.nix-defexpr
if [[ -e $NIX_LINK ]]; then
  # source $HOME/.nix-profile/etc/profile.d/nix.sh
  # source /nix/var/nix/profiles/default/etc/profile.d/nix.sh
  source $NIX_LINK/etc/profile.d/nix.sh
  export MANPATH=$NIX_LINK/share/man:$MANPATH
  export NIX_PATH=nixpkgs=$NIX_EXPR/nixpkgs
fi

#
# Linuxbrew
#
#export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH=$HOME/.linuxbrew/share/man:$MANPATH
export INFOPATH=$HOME/.linuxbrew/share/info:$INFOPATH
export XDG_DATA_DIRS=$HOME/.linuxbrew/share:$XDG_DATA_DIRS

#
# Direnv / Autoenv
#

#
# Nax/xenv or riywo/anyenv
#
#xenvs=('rbenv' 'pyenv' 'nodenv' 'goenv')
#for xenv in $xenvs
#do
#  if [[ -s /usr/local/bin/$xenv || -s $HOME/.linuxbrew/bin/$xenv ]] {
#    export PATH="$HOME/.$xenv/bin:$PATH"
#    eval "$($xenv init -)"
#  }
#done

#
# Lisp
#
## roswell ( https://github.com/roswell/roswell )

#
# Golang ( https://golang.org/dl/ )
#
# check: `go env`
export GOROOT=$XDG_DATA_HOME/golang/go                    # ~/.local/share/golang/go
export GOPATH=$HOME/.local/lib/go
export GOMAXPROCS=4
#export GOARCH=amd64
#export GOOS=${$(uname -s):l}
if [ ! -d $GOPATH ];then
  mkdir -p $GOPATH
fi

#
# Node.js & {npm, yarn} ( NodeSource repo )
#
# version manager: creationix/nvm, tj/n, nodenv/nodenv or riywo/ndenv

# https://github.com/npm/npm/issues/6675
# see `npm config ls -l | grep /`
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config  # npmrc
export NOM_CONFIG_PREFIX=$HOME/.local/lib/node_modules
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_TMP=$XDG_RUNTIME_DIR/npm
## REPL https://nodejs.org/api/repl.html#repl_environment_variable_options
export NODE_REPL_HISTORY=$XDG_DATA_HOME/node/node_repl_history
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE=32768

#
# Python
#
## python
export PYTHONIOENCODING=utf-8
#export PYTHONDONTWRITEBYTECODE=true
## pip
export PIP_DOWNLOAD_CACHE=$XDG_CACHE_HOME/pip/cache
export PIP_USE_MIRRORS=true
## pyenv https://github.com/yyuu/pyenv
## https://github.com/zmwangx/dotfiles/tree/master/pyenv
export PYENV_HOME=$HOME/.pyenv
## virtualenvwrapper
## https://virtualenv.pypa.io/en/latest/reference/#configuration
## https://virtualenvwrapper.readthedocs.io/
export WORKON_HOME=$PYENV_HOME/virtualenvs
export VIRTUALENV_DISTRIBUTE=true
export VIRTUALENVWRAPPER_HOOK_DIR=$PYENV_HOME/virtualenvwrapper_hooks
export VIRTUALENVWRAPPER_WORKON_CD=0
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV=1

#
# Ruby ( apt install ruby2.3 ruby2.3-dev )
#
## $HOME/.gem/ruby/2.3.0
#GEM_HOME=$(ls -t -U | ruby -e 'puts Gem.user_dir')
#GEM_PATH=$GEM_HOME
#export PATH=$GEM_HOME/bin:$PATH

## ~/.local/share/gem/ruby/2.3.0
export RUBY_VERSION=2.3.0
export GEMRC=$XDG_CONFIG_HOME/gem/config
export GEM_SPEC_CACHE=$XDG_CACHE_HOME/gem/specs
export BUNDLE_JOBS=4
# Update gem home only for non-root user
if [[ "$EUID" -ne 0 ]]; then
  export GEM_HOME=$HOME/.local/lib/gem  # $HOME/.local/lib/gem/ruby/$RUBY_VERSION
  export GEM_PATH=$GEM_HOME
fi

## rbenv
# https://github.com/yuya373/dotfiles/blob/master/.zenv

## REPL
export IRBRC=$XDG_CONFIG_HOME/ruby/irbrc
export PRYRC=$XDG_CONFIG_HOME/ruby/pryrc

## Static Code Analyzer ( .rubocop.yml )
## Debugging ( .byebugrc or .rdebugrc )

#
# Rust ( sh -c "$(curl -sSf https://static.rust-lang.org/rustup.sh)" )
#
export CARGO_HOME=$HOME/.local/lib/cargo      # default: ~/.cargo
#export PATH=$CARGO_HOME/bin:$PATH
#export RUST_SRC_PATH=~/src/github.com/rust-lang/rust/src
export RUST_NEW_ERROR_FORMAT=true

#
# SQL
#
#export MYSQL_HISTFILE=$XDG_DATA_HOME/mysql_history

# ----------------------------------------------------------------------
# CLI Tools
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
# Paths
# ----------------------------------------------------------------------
# -U for Unique, like a set
typeset -gx -U cdpath CDPATH fpath FPATH path PATH

#
# for `cd` command
#
cdpath+=(
  $HOME/.own                                  # my personal config files
  $XDG_CONFIG_HOME                            # ~/.config
  $GOPATH/src/github.com(N-/)
)

#
# functions
#
fpath+=(
  /usr/local/share/zsh/site-functions(N-/)
  $ZPLUG_REPOS/zsh-users/zsh-completions/src  # zsh-users/zsh-completions repo
  $ZSHCONF/func(N-/)                          # custom zsh functions
  $ZSHCONF/comp(N-/)                          # custom zsh completions
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
  $HOME/.nix-profile/bin                      # Nix
  $HOME/.linuxbrew/bin                        # Linuxbrew
  $HOME/.local/share/umake/bin                # Ubuntu Make
  $HOME/.yarn/bin                             # Yarn ( NPM alternative )
  #$HOME/.gem/ruby/*/bin(N)                   # Local Ruby packages ( or $(ruby -e 'print Gem.user_dir')/bin )
  $GEM_HOME/bin                               # Local Ruby packages
  $CARGO_HOME/bin                             # Local Rust packages
  $GOROOT/bin                                 # Golang
  $GOPATH/bin                                 # Local Go packages
  $XDG_DATA_HOME/node/bin                     # Local Node.js packages ( NPM: npmrc )
)

#
# ignored patterns
#
#fignore+=(
#  .DS_Store
#)
