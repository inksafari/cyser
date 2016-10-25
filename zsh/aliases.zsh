#!/usr/bin/env zsh

# List all defined aliases: alias

# PTT ( Telnet BBS )
alias ptt='ssh bbsu@ptt.cc'
alias pt2='ssh bbsu@ptt2.cc'

# weather report
alias weather='curl http://wttr.in'

# command line pastebin
alias clbin="curl -F 'clbin=<-' https://clbin.com"

#
# Update
#
alias brewup='sudo softwareupdate -i -a && brew update && brew upgrade && brew cleanup'
alias pip2up='pip2 list | cut -d' ' -f1 | xargs pip2 --no-cache-dir install -U'
alias pip3up='pip3 list | cut -d' ' -f1 | xargs pip3 --no-cache-dir install -U'
alias gemup='gem update --system && gem update && gem cleanup'
alias npmup='npm install -g npm@latest && npm -g update'

# Reload the shell (i.e. invoke as a login shell)
alias reload='exec $SHELL -l'

#
# Editors
#
#alias gtags='starscope -e ctags'
alias nano='nano -c'    # starts nano with line number enabled
case ${OSTYPE} in
  darwin*)
    # CotEditor https://coteditor.com/
    alias cot='open -a coteditor'
  ;;
  linux*)
    # Visual Studio Code https://github.com/Microsoft/vscode/issues/3068
    alias sucode = 'sudo code --user-data-dir=$XDG_CONFIG_HOME/Code'  # without sudo permission: code
  ;;
esac

#
# O ( Open )
#
if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open . &'
elif [[ "$OSTYPE" == linux* ]]; then
  alias o='xdg-open'
fi

#
# Suffix aliases
#
#alias -s html='o'  # or firefox

#
# Permission
#
alias sudo='sudo '
alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'
alias rm='rm -I --preserve-root'
alias chgrp='chgrp --preserve-root'
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'

#
# ls ( List directory contents )
#
source 'aliases/ls.zsh'

## Tree
alias t1='tree -CFL 1'
alias t2='tree -CFL 2'
alias t3='tree -CFL 3'
alias t4='tree -CFL 4'

alias t1a='tree -CFLa 1'
alias t2a='tree -CFLa 2'
alias t3a='tree -CFLa 3'
alias t4a='tree -CFLa 4'

#
# cd
#
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
## directory stack
alias pu='pushd'
alias po='popd'
alias d='dirs -v | head -n 10 | sort -k 2'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

#
# Handy pipes
#
alias -g H='| head -n'
alias -g W='| wc -l'
alias -r T='tail -f'
alias peek='tee >(cat 1>&2)'

#
# Clipboard
#
if (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard -in'   # cat | xclip -i -sel c -f | xclip -i -sel p
    alias pbpaste='xclip -selection clipboard -out'
elif (( $+commands[xsel] )); then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
fi

#
# Git
#
if [[ -n $commands[hub] ]]
then
    compdef _hub hub
    alias git=hub
    alias gh=hub
fi

#
# File Download / Sync
#
if (( $+commands[curl] )); then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
  alias get='wget --continue --progress=bar --timestamping'
fi
## wget
alias mirror='wget --mirror --no-parent --recursive --timestamping --continue --recursive $1'
alias mirrorsite='wget -m -k -K -E -e robots=off'
## rsync
alias rsync='rsync -avhP'

# multithreaded archivers
# or https://github.com/z0rc/dotfiles/blob/master/zsh/zshrc
which pigz 2>&1 >/dev/null && alias gzip='pigz'
which pbzip2 2>&1 >/dev/null && alias bzip2='pbzip2'

#
# Greplike tools
#
## Grep  https://github.com/mathiasbynens/dotfiles/issues/467
GREP_OPTIONS+='--color=auto --line-number --exclude=*.pyc --exclude-dir={node_modules,bower_components,vendor,dist,.git,.tmp}'
alias grep="LC_ALL=C grep $GREP_OPTIONS"

#if (( $+commands[ag] )); then
#  alias pt='ag --path-to-agignore ~/.agignore'
#fi
#if (( $+commands[fzf] )); then
#fi

#
# System info
#
## memory
alias meminfo='free -m -l -t'

## list files by size
alias ssize='df -h'   # or `df -Th`
alias fsize='du -hs * | sort -hr'  # for current dir
#alias dspace='du --dereference --max-depth=2 -h . | sort -h -r | head -n 20'

## list top memory / cpu consuming processes
## http://sourcedigit.com/20413-check-top-10-cpu-consuming-process-linux-ubuntu/
alias psm = 'ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head'
alias psc = 'ps -eo pid,comm,%cpu | sort -rk 3 | head'

#
# Networking
#
# http://www.cyberciti.biz/faq/how-to-find-my-public-ip-address-from-command-line-on-a-linux/
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias exip='curl -s icanhazip.com'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias mygeoip='geoiplookup $(myip)'
alias mtr='mtr -rwc 10'
alias nsoa='nslookup -type=soa'
alias ports='netstat -tulanp'
alias val='valgrind -v --leak-check=full --show-reachable=yes'
## iptables
## http://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html
alias iptlist='sudo iptables -L -n -v --line-numbers'
alias iptlistin='sudo iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
## One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done

#
# CLI tools
#
## stopwatch ( or unixorn/jpb.zshplugin/blob/master/jpb.plugin.zsh )
alias now='date +"%T"'
alias timer='echo "Timer started. Stop with Ctrl-D." && now && time cat && now'
## cloc ( github.com/AlDanial/cloc )
alias cloc='cloc --vcs git --exclude-dir=draft . | tail -8'
## diff ( jeffkaufman/icdiff )
which icdiff 2>&1 >/dev/null && alias diff='icdiff -U 1 --line-numbers'
## fortune cookies
alias cowl='cowsay -l'
alias cow='fortune | cowsay -f moose | lolcat'
## linters
alias golint='gometalinter --fast'         # Golang ( alecthomas/gometalinter )
## TLDR cheat sheets ( tldr-pages/tldr )
alias "?"=tldr
## Translate Shell ( soimort/translate-shell )
alias tre='trans :en'
alias trz='trans :zh'

#
# Tmux
#
alias tmux='tmux -2'    # Run tmux in 256 color mode
alias ta='tmux attach -t main || tmux new -s main'
alias td='tmux detach'
alias ts='tmux ls'
if [[ "$OSTYPE" = darwin* ]]; then
  alias tmux='tmux -f $XDG_CONFIG_HOME/tmux.mac.conf'
fi
