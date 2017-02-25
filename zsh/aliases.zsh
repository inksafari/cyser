# List all defined aliases: alias

[[ -n $ZSH_DEBUG ]] && STARTTIME="$(($(date +%s%N)/1000000))"

#
# Linux / macOS
#
#if [[ "$OSTYPE" == darwin* ]]; then
#elif [[ "$OSTYPE" == linux* ]]; then
#fi

# https://coderwall.com/p/zkwhqq/find-linux-distro
SYSTEM=$(uname -a | awk '{print $1}')
if [ $SYSTEM = "Linux" ] ; then
  if [ "$(which lsb_release)" ] ; then
    DISTRO=$(lsb_release -is 2>/dev/null)
  elif [ -f /etc/issue.net ] ; then
    DISTRO=$(head -1 /etc/issue.net | sed 's/\([a-zA-Z]*\)\([0-9].*\)/\1/g' | sed 's/release//')
    DISTRO=${DISTRO// /}
  else
    echo "Could not find Linux distro"
  fi
fi

case ${OSTYPE} in
  darwin*)
    # nproc - max number of processes
    alias nproc='sysctl -n hw.ncpu'
    # Open
    alias o='reattach-to-user-namespace open . &'
    # CotEditor https://coteditor.com/
    alias cot='open -a coteditor'
    # Update
    alias brewup='sudo softwareupdate -i -a && brew update && brew upgrade && brew cleanup'
    # Tmux
    alias tmux='tmux -u2 -f $XDG_CONFIG_HOME/tmux/tmux.mac.conf'
    # https://github.com/loliee/dotfiles/blob/master/.aliases.osx
    # Clean up LaunchServices to remove duplicates in the “Open With” menu
  alias lscleanup='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder'
  ;;
  linux*)
    # Open
    alias o='xdg-open'
    # Visual Studio Code https://github.com/Microsoft/vscode/issues/3068
    alias sucode = 'sudo code --user-data-dir=$XDG_CONFIG_HOME/Code'  # without sudo permission: code
    # Clipboard
    if (( $+commands[xclip] )); then
        alias pbcopy='xclip -selection clipboard -in'   # cat | xclip -i -sel c -f | xclip -i -sel p
        alias pbpaste='xclip -selection clipboard -out'
    elif (( $+commands[xsel] )); then
        alias pbcopy='xsel --clipboard --input'
        alias pbpaste='xsel --clipboard --output'
    fi
    # Update
    alias brewup='brew update && brew upgrade && brew cleanup'
    if [ ${DISTRO} =~ "(Ubuntu|LinuxMint)" ]; then
        # apt ( Debian / Ubuntu )
        # Debian: aptitude; Ubuntu 16.04: apt-get -> apt
        alias aptup='sudo apt update && sudo apt upgrade && sudo apt autoremove'
        alias aptv='apt-cache madison'  # pkg version: https://repology.org
    elif [ ${DISTRO} = "Arch" ] ; then
        alias aurup='sudo -E pacman -Syyu'
    fi
    # Tmux
    alias tmux='tmux -u2 -f $XDG_CONFIG_HOME/tmux/tmux.conf'
  ;;
  # cygwin|msys*)
  # ;;
esac

#
# Update
#
alias pip2up='pip2 list | cut -d' ' -f1 | xargs pip2 --no-cache-dir install -U'
alias pip3up='pip3 list | cut -d' ' -f1 | xargs pip3 --no-cache-dir install -U'
alias gemup='gem update --system && gem update && gem cleanup'
alias npmup='npm install -g npm && npm -g update'

#
# Editors
#
#alias gtags='starscope -e ctags'
alias nano='nano -c'    # starts nano with line number enabled

#
# Suffix aliases
#
#alias -s html='o'  # or firefox
#alias -s py=python
#alias -s pl=perl
alias -s rb=ruby

#
# Permission
#
# https://github.com/zchee/dotfiles/blob/master/.config/zsh/alias.zsh
alias _='sudo '
alias sudo='nocorrect sudo '
alias cp='nocorrect cp -iv'  # -i to prompt for every file
alias ln='nocorrect ln -iv'
alias mv='nocorrect mv -iv'
alias rm='nocorrect rm -Iv'  # -I to prompt when more than 3 files
alias mkdir='nocorrect mkdir -p'
alias chgrp='chgrp --preserve-root'
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'

#
# ls ( List directory contents )
#


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
# Easier navigation
#
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
## directory stack
alias pu='pushd'
alias po='popd'
alias d='dirs -v | head -n 10 | sort -k 2'
# cd -, cd -2, cd -3, ...

#
# Handy pipes
#
alias -g H='| head -n'
alias -g W='| wc -l'
alias -r T='tail -f'
alias peek='tee >(cat 1>&2)'

#
# Git
#
## cd to git root directory
alias cdgr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'

## lines count ( https://github.com/exAspArk/dotfiles/blob/master/zsh/custom/git.plugin.zsh )
alias glst='git ls-files -z | xargs -0n1 git blame -w --line-porcelain | grep -a "^author " | sort -f | uniq -c | sort -n -r'

## motemen/ghq
# https://github.com/momo-lab/zsh-abbrev-alias
# https://github.com/39e/dotfiles/blob/master/config/zplug/plugins/abbrev-alias.zsh
if (( $+commands[ghq] )); then
    abbrev-alias gg="ghq get"
    abbrev-alias gl="ghq list"
fi

## github/hub
if (( $+commands[hub] )); then
    abbrev-alias g="hub"
fi
#if [[ -n $commands[hub] ]]
#then
#    compdef _hub hub
#    alias git=hub
#    alias gh=hub
#fi

#
# Download / Sync / (Un)pack
#
if (( $+commands[curl] )); then
    alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
    alias get='wget --continue --progress=bar --timestamping'
fi
## Downloading an entire website with Wget
## https://www.guyrutenberg.com/2014/05/02/make-offline-mirror-of-a-site-using-wget/
## or https://github.com/hartator/wayback-machine-downloader
alias mirror='wget --mirror --no-parent --recursive --timestamping --continue --recursive $1'
alias mirrorsite='wget -r -l0 -np -k -e robots=off' # or 'wget -m -k -K -E -e robots=off'

## rsync
## http://blog.opskumu.com/rsync.html
alias rsync='rsync -avhP --itemize-changes'

# multithreaded archivers
# or https://github.com/z0rc/dotfiles/blob/master/zsh/zshrc
which pigz 2>&1 >/dev/null && alias gzip='pigz'
which pbzip2 2>&1 >/dev/null && alias bzip2='pbzip2'

#
# Grep-like tools ( ack, ag, pt and rp )
#
## Grep  https://github.com/mathiasbynens/dotfiles/issues/467
GREP_OPTIONS+='--color=auto --line-number --exclude=*.pyc --exclude-dir={node_modules,bower_components,vendor,dist,.git,.tmp}'
alias grep="LC_ALL=C grep $GREP_OPTIONS"
## ack  https://beyondgrep.com/
## ag   https://geoff.greer.fm/ag/
if (( $+commands[ag] )); then
    alias ag='ag -U --path-to-agignore $XDG_CONFIG_HOME/greps/agignore'  # or ~/.agignore
fi
## pt   https://github.com/monochromegane/the_platinum_searcher
## rp   http://blog.burntsushi.net/ripgrep/

#
# System info
#
alias listen='sudo lsof -i -P'
## memory
alias meminfo='free -m -l -t'

## list files by size
alias df='df -Th'
alias fsize='du -hs * | sort -hr'  # for current dir
#alias dspace='du --dereference --max-depth=2 -h . | sort -h -r | head -n 20'

## list top memory / cpu consuming processes
## http://sourcedigit.com/20413-check-top-10-cpu-consuming-process-linux-ubuntu/
alias psm = 'ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head'
alias psc = 'ps -eo pid,comm,%cpu | sort -rk 3 | head'

## Get maximum open files count allowed
alias max_open_files='cat /proc/sys/fs/file-max'

#
# Networking
#
# https://www.cyberciti.biz/faq/how-to-find-my-public-ip-address-from-command-line-on-a-linux/
alias addr="ip -o a | cut -d ' ' -f2,7"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias myip='dig +short whoami.akamai.net @ns1-1.akamaitech.net'
alias mygeoip='curl -s https://tools.keycdn.com/geo.json?host='  # or `geoiplookup $(myip)`
alias mtr='mtr -rwc 100'
alias nsoa='nslookup -type=soa'
alias ports='netstat -tulanp'
alias val='valgrind -v --leak-check=full --show-reachable=yes'
## iptables
## https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html
## https://github.com/loliee/dotfiles/blob/master/.aliases
alias iptlist='sudo iptables -L -n -v --line-numbers'
alias iptlistin='sudo iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist
## HTTP traffic
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
## One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="lwp-request -m '$method'"
done

#
# CLI tools & Online Services
#
## stopwatch ( or unixorn/jpb.zshplugin/blob/master/jpb.plugin.zsh )
alias now='date +"%T"'
alias timer='echo "Timer started. Stop with Ctrl-D." && now && time cat && now'
## cloc ( github.com/AlDanial/cloc )
alias cloc='cloc --vcs git --exclude-dir=draft . | tail -8'
## command line {pastebin, ooo, .. }
## https://blog.kuoe0.tw/posts/2016/05/27/cli-share-source-code-from-terminal/
alias clbin="curl -F 'clbin=<-' https://clbin.com"
alias datafart='curl --data-binary @- datafart.com'
## diff ( jeffkaufman/icdiff )
which icdiff 2>&1 >/dev/null && alias diff='icdiff -U 1 --line-numbers'
## fortune cookies
alias cowl='cowsay -l'
alias cow='fortune | cowsay -f moose | lolcat'
## linters
# Golang: caarlos0/dotfiles/blob/master/golang/aliases.zsh
## PTT ( Telnet BBS )
alias ptt='ssh bbsu@ptt.cc'
alias pt2='ssh bbsu@ptt2.cc'
## Taskwarrior
## TLDR cheat sheets ( tldr-pages/tldr )
alias "?"=tldr
## Translate Shell ( soimort/translate-shell )
alias tre='trans :en'
alias trz='trans :zh'
## Watson ( TailorDev/Watson ) or Trackmac ( MacLeek/trackmac )
## weather report
alias weather='curl http://wttr.in'
## webkit2png ( paulhammond/webkit2png )
# https://blog.kuoe0.tw/posts/2013/08/14/take-screenshot-of-web-pages-under-cli/
# https://github.com/andersonfreitas/dotfiles/blob/master/bash/aliases.bash
alias w2png='webkit2png -C --clipwidth=1024 --clipheight=1366 --scale=1.0 --dir=~/Desktop/'
## YouTube-dl
alias ydl='youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best/best"'

#
# Tmux
#
alias ta='tmux attach -t main || tmux new -s main'
alias td='tmux detach'
alias ts='tmux ls'

#
# Misc
#
alias path='echo $PATH | tr -s ":" "\n"'
alias passgen='openssl rand -base64 14 | pbcopy'
# zsh profiling
alias zshstartuptime='time ( ZSH_DEBUG=1 zsh -i -c exit )'
# Reload the shell (i.e. invoke as a login shell)
alias reload='exec $SHELL -l'

[[ -n $ZSH_DEBUG ]] && ENDTIME="$(($(date +%s%N)/1000000))" && echo "loaded $(basename ${0:a}):			$(($ENDTIME - $STARTTIME))"
