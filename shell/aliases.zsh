#!/usr/bin/env zsh
# List all defined aliases: alias

[[ -n $ZSH_DEBUG ]] && STARTTIME="$(($(date +%s%N)/1000000))"

#
# Linux / macOS
#
case ${OSTYPE} in
  darwin*)
    # free
    alias free='top -l 1 -s 0 | grep PhysMem'
    # nproc - max number of processes
    alias nproc='sysctl -n hw.ncpu'
    # Open
    alias o='reattach-to-user-namespace open . &'
    # Applications
    alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
    alias cot='open -a coteditor'  #CotEditor https://coteditor.com/
    alias safari_techpre='open -a Safari\ Technology\ Preview' # url as arg1, url must begin with http:// or https://
    alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl '
    # Update
    alias brewup='sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup; brew prune; mas outdated; mas upgrade; brew doctor'
    alias clr-up='sudo softwareupdate --clear-catalog' # Clear software updates (useful after turning off beta updates)
    # Tmux
    alias tmux='tmux -u2 -f $XDG_CONFIG_HOME/tmux/tmux.mac.conf'
    # macOS
    # https://github.com/herrbischoff/awesome-osx-command-line
    # https://gist.github.com/cmckni3/f653e80bd0e27bbde1920c32e9f5d142
    # https://github.com/rub1/dotfiles/blob/master/zsh/config/alias.zsh
    alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
    alias flush='dscacheutil -flushcache && killall -HUP mDNSResponder'
    # Clean up LaunchServices to remove duplicates in the “Open With” menu
    alias lscleanup='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder'
    alias permissions='diskutil repairPermissions /'
  ;;
  linux*)
    # Open
    alias open='xdg-open'
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
    if [ $DISTRO =~ "(Ubuntu|LinuxMint)" ]; then
        # apt ( Debian / Ubuntu )
        # Debian: aptitude; Ubuntu 16.04: apt-get -> apt
        alias aptls="comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)"
        alias aptup='sudo apt update && sudo apt upgrade && sudo apt autoremove'
        alias aptv='apt-cache policy'  # pkg version: https://repology.org
        alias depends='apt-cache depends'
        alias csearch='apt-cache search'
        alias fsearch='apt-file search'
    elif [ $DISTRO = "Arch" ] ; then
        alias aurup='sudo -E pacman -Syyu'
    fi
    # systemd
    if (( $+commands[systemctl] )); then
        alias jc='journalctl --since=today'
        alias jce='journalctl --since=today --priority=0..3'
        alias jcb='journalctl --boot'
        alias jcf='journalctl --follow'
        alias jcu='journalctl --unit'
        alias jcuu='journalctl --user-unit'

        alias sc='systemctl'
        alias scs='systemctl status'
        alias scl='systemctl list-units'

        alias scu='systemctl --user'
        alias scus='systemctl --user status'
        alias scul='systemctl --user list-units'

        alias reboot='systemctl reboot'
        alias poweroff='systemctl poweroff'
        alias suspend='systemctl suspend'
    else
        # shutdown, reboot
        alias halt='sudo shutdown -h now'  # alias halt='sudo poweroff'
        alias rbt='sudo reboot'
    fi
    # Tmux
    alias tmux='tmux -u2 -f $XDG_CONFIG_HOME/tmux/tmux.conf'
    # Utils
    alias brightness="xrandr --output $(xrandr -q | grep ' connected' | awk '{print $1}') --brightness"
  ;;
esac

#
# Update
#
# https://github.com/Quexint/upm
alias pip2up='pip2 list | cut -d' ' -f1 | xargs pip2 --no-cache-dir install -U'
alias pip3up='pip3 list | cut -d' ' -f1 | xargs pip3 --no-cache-dir install -U'
alias gemup='gem update --system && gem update && gem cleanup'
alias npmup='npm install -g npm && npm -g update'
alias texup='tlmgr update --self --all'
alias bump='pip2up; pip3up; gemup; npmup; texup'

#
# Uninstall
#
alias gemrm='gem list | cut -d' ' -f1 | xargs gem uninstall -aIx'

#
# NPM
#
alias npmri='npm cache clean && rm -rf node_modules && npm install'

#
# Python
#
if hash python3 2>/dev/null; then
    alias httpserver='python3 -m http.server'
elif hash python2 2>/dev/null; then
    alias httpserver='python2 -m SimpleHTTPServer'
fi

#
# Ruby
#
alias bi='bundle install --path vendor/bundle'

#
# Editors
#
#alias gtags='starscope -e ctags'
#alias vperf="vim --startuptime /tmp/startup.log +q && vim /tmp/startup.log" # profile startup time
alias nano='nano -c'    # starts nano with line number enabled


#
# Suffix aliases
#
#alias -s html='o'  # or firefox
#alias -s py=python
#alias -s pl=perl
alias -s rb=ruby
alias -s {mpg,mp4}=mpv
#alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract  # extract func

#
# Permission
#
# https://github.com/zchee/dotfiles/blob/master/.config/zsh/alias.zsh
alias _='sudo '
# autoload -U zmv
alias zmv='noglob zmv -W'
alias find='noglob find'
alias sudo='nocorrect sudo '
alias cp='nocorrect cp -iv'      # -i to prompt for every file
alias ln='nocorrect ln -iv'
alias mv='nocorrect mv -iv'
alias rm='nocorrect rm -Iv'      # -I to prompt when more than 3 files
alias mkdir='nocorrect mkdir -p' # Automatically make parent dirs
alias chgrp='chgrp --preserve-root'
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'

#
# ls ( List directory contents )
#


## Tree
#alias tree='tree --dirsfirst -C'

#
# Easier navigation
#
alias -g ...='../..'              # aliases with -g will get expanded even inside commands
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
## directory stack
alias pu='pushd'
alias po='popd'
alias d='dirs -v | head -n 10 | sort -k 2'  # List 10 last paths
# cd -, cd -2, cd -3, ...
# https://github.com/paulmillr/dotfiles/blob/master/terminal/startup.sh
# for index ({1..9}) alias "$index"="cd +${index}"; unset index

#
# Named directories
#
#setopt CDABLE_VARS
#hash -d B=$HOME/labs/blog
#hash -d bin=$HOME/.bin
#hash -d app=$HOME/Applications
#hash -d dow=$HOME/Downloads
#hash -d doc=$HOME/Documents
#hash -d mus=$HOME/Music
#hash -d pic=$HOME/Pictures

#
# Abbreviations
#

#
# Handy pipes
#
alias -g H='| head -n'
alias peek='tee >(cat 1>&2)'
alias -g S='| sort'
alias -r T='tail -f'
alias -g W='| wc -l'
alias -g NL='>/dev/null'
alias -g NLL='>/dev/null 2>&1'

#
# Git
#
## change into git repo's top-level directory ( cd $(git rev-parse --show-toplevel) )
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
alias mirror='wget --mirror --no-parent --recursive --timestamping --continue --recursive $1' # alias mirror='rsync -rPhity --delete-after'
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
GREP_OPTIONS+='--line-number --exclude=*.pyc --exclude-dir={node_modules,bower_components,vendor,dist,.git,.tmp}'
alias grep='LC_ALL=C grep $GREP_OPTIONS'
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
alias ports='sudo lsof -iTCP -sTCP:LISTEN -P'
alias val='valgrind -v --leak-check=full --show-reachable=yes'
# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"
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
## haste() { a=$(cat); curl -X POST -s -d "$a" https://hastebin.com/documents | awk -F '"' '{print "https://hastebin.com/"$4}'; }
alias clbin="curl -F 'clbin=<-' https://clbin.com"
alias datafart='curl --data-binary @- datafart.com'
## cat ( jingweno/ccat )
which ccat 2>&1 >/dev/null && alias cat='ccat'
## diff ( jeffkaufman/icdiff )
which icdiff 2>&1 >/dev/null && alias diff='icdiff -U 1 --line-numbers'
## fortune cookies
alias cowl='cowsay -l'
alias cow='fortune | cowsay -f moose | lolcat'
## linters
# Golang: caarlos0/dotfiles/blob/master/golang/aliases.zsh
## password manager: passpie, sudolikeboss(1password), ...
## https://wiki.archlinux.org/index.php/Pass
## PTT ( Telnet BBS )
alias ptt='ssh bbsu@ptt.cc'  # 無法以 mosh 取代
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
# Miscellaneous
#
alias nodups="awk '!x[\$0]++'"  # remove duplicate lines in a file without sorting ( elasticdog/dotfiles )
alias copyLastCmd='fc -ln -1 | pbcopy'
alias cwd='pwd | tr -d "\r\n" | pbcopy'  # copy working directory
alias path='echo $PATH | tr -s ":" "\n"' # or `echo -e ${PATH//:/\\n}`
alias passgen='openssl rand -base64 14 | pbcopy'
alias pubkey="more ~/.ssh/id_rsa*.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
# zsh profiling
alias zshstartuptime='time ( ZSH_DEBUG=1 zsh -i -c exit )'
# Reload the shell (i.e. invoke as a login shell)
alias reload='exec $SHELL -l'
alias :q='exit'

[[ -n $ZSH_DEBUG ]] && ENDTIME="$(($(date +%s%N)/1000000))" && echo "loaded $(basename ${0:a}):			$(($ENDTIME - $STARTTIME))"
