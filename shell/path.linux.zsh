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

# systemd
# https://github.com/terlar/dotfiles/blob/master/systemd/.config/systemd/user/ibus.service

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
# SHELL
# ----------------------------------------------------------------------
# Direnv / Autoenv / Desk(jamesob/desk) ---------------------------- {{{


# ueokande/shvm: A Version Manager for Shells ---------------------- {{{


# ----------------------------------------------------------------------
# Nix & Linuxbrew
# ----------------------------------------------------------------------
#
# Linuxbrew
#
#export PATH=$HOME/.linuxbrew/bin:$PATH
export MANPATH=$HOME/.linuxbrew/share/man:$MANPATH
export INFOPATH=$HOME/.linuxbrew/share/info:$INFOPATH
export XDG_DATA_DIRS=$HOME/.linuxbrew/share:$XDG_DATA_DIRS

# ----------------------------------------------------------------------
# Programming Languages & Packages Managers
# ----------------------------------------------------------------------

# Nax/xenv, riywo/anyenv or asdf-vm/asdf --------------------------- {{{

# Golang ----------------------------------------------------------- {{{
# https://golang.org/dl/
export GOROOT=$HOME/.local/lib/golang  # Ubuntu ( apt ): /usr/lib/go-1.x
# check: `go env`
#export GOARCH=amd64
#export GOOS=${$(uname -s):l}
#export GOMAXPROCS=4
export GOPATH=$HOME/.local/lib/go      # or ~/src/go
[[ ! -d $GOPATH ]] && mkdir -p $GOPATH

# Node.js ( NodeSource repo ) & {npm, yarn} ------------------------ {{{
## version manager: creationix/nvm, tj/n, nodenv/nodenv or riywo/ndenv
## NPM
export NPM_CONFIG_PREFIX=$HOME/.local/lib/node_modules  # npmrc: prefix=/path/to/NPM_PACKAGES
[[ ! -d $NPM_CONFIG_PREFIX ]] && mkdir -p $NPM_CONFIG_PREFIX
## Yarn  ( NPM alternative )
export YARNBIN=`yarn global bin`

# Lua & LuaRocks --------------------------------------------------- {{{


# Python ----------------------------------------------------------- {{{

## pip
export PIP_DOWNLOAD_CACHE=$XDG_CACHE_HOME/pip/cache
export PIP_USE_MIRRORS=true
## pipenv

# Ruby ( ppa:brightbox/ruby-ng ) ----------------------------------- {{{
export GEMRC=$XDG_CONFIG_HOME/ruby/gemrc        # $XDG_CONFIG_HOME/gem/config
export GEM_SPEC_CACHE=$XDG_CACHE_HOME/gem/specs # ~/.local/share/gem/ruby/2.3.0
export BUNDLE_JOBS=4
# Update gem home only for non-root user
if [[ $EUID -ne 0 ]]; then
    #export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
    export RUBY_VERSION=2.3.0                 # $HOME/.gem/ruby/2.3.0
    export GEM_HOME=$HOME/.local/lib/gem      # $HOME/.local/lib/gem/ruby/$RUBY_VERSION
    export GEM_PATH=$GEM_HOME
    #export PATH=$GEM_HOME/bin:$PATH
fi
# PATH=(
#   $HOME/.gem/ruby/*/bin(N)                  # or $(ruby -e 'print Gem.user_dir')/bin
#)

## version manager: rbenv, chruby
## REPL
export IRBRC=$XDG_CONFIG_HOME/ruby/irbrc
export PRYRC=$XDG_CONFIG_HOME/ruby/pryrc
## Static Code Analyzer ( .rubocop.yml )
## Debugging ( .byebugrc or .rdebugrc )

# Rust ( sh -c "$(curl -sSf https://static.rust-lang.org/rustup.sh)" )
# ------------------------------------------------------------------ {{{
export CARGO_HOME=$HOME/.local/lib/cargo      # default: ~/.cargo
#export PATH=$CARGO_HOME/bin:$PATH
#export RUST_SRC_PATH=~/src/github.com/rust-lang/rust/src
export RUST_NEW_ERROR_FORMAT=true

# ----------------------------------------------------------------------
# Paths
# ----------------------------------------------------------------------
# Setup INFOPATH like manpath
typeset -T INFOPATH infopath ":"
export INFOPATH

# U for Unique, like a set; (N) -> only if exists
typeset -gx -U cdpath CDPATH fpath FPATH path PATH

#
# manuals
#
#manpath+=($HOME/.fzf/man(N-/) $manpath)

#
# for `cd` command
#
cdpath=(
  $HOME/.own                                  # my personal config files
  $XDG_CONFIG_HOME                            # ~/.config
  $GOPATH/src/github.com(N-/)
)

#
# functions & completions
#
fpath+=(
  /usr/local/share/zsh/site-functions(N-/)
  $ZPLUG_REPOS/zsh-users/zsh-completions/src  # zsh-users/zsh-completions repo
  $ZSHCONF/func(N-/)                          # custom zsh functions
  $ZSHCONF/comp(N-/)                          # custom zsh completions
)

#
# ignored patterns
#
#fignore+=(
#  .DS_Store
#)

#
# programs ( check: echo -e ${PATH//:/\\n} )
#
# https://github.com/lunaryorn/dotfiles/blob/master/zsh/.zprofile
# https://github.com/Alexendoo/dotfiles/blob/master/zsh/path.zsh
PATH=(
  ${/usr/local,/usr,}/bin(N-/)                # speg03/dotfiles: zshenv
  ${/usr/local,/usr,}/sbin(N-/)
  /usr/local/texlive/2016/bin/x86_64-linux    # TeX
  /usr/share/doc/git/contrib/diff-highlight   # Git diff-highlight
  $HOME/.linuxbrew/bin                        # Linuxbrew
  $HOME/.local/bin                            # Local executables from Python
  $HOME/bin                                   # Personal executables
  $HOME/anaconda3/bin(N-/)                    # Anaconda for py3
  $GOROOT/bin                                 # Golang
  $GOPATH/bin                                 # Local Go packages
  $GEM_HOME/bin                               # Local Ruby packages
  $CARGO_HOME/bin                             # Local Rust packages
  $NPM_CONFIG_PREFIX                          # Local Node.js packages ( NPM: npmrc )
  $YARNBIN                                    # Yarn ( NPM alternative )
  $path[@]
)
