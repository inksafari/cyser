#!/usr/bin/env zsh
# - https://github.com/gautamborad/fs-dotfiles/blob/master/source/50_alias_git.sh

# GitHub URL for current repo.
function gurl() {
  local remotename="${@:-origin}"
  local remote="$(git remote -v | awk '/^'"$remotename"'.*\(push\)$/ {print $2}')"
  [[ "$remote" ]] || return
  local user_repo="$(echo "$remote" | perl -pe 's/.*://;s/\.git$//')"
  echo "https://github.com/$user_repo"
}

# GitHub URL for current repo, including current branch + path.
alias gurlp='echo $(gurl)/tree/$(gbs)/$(git rev-parse --show-prefix)'

# git log with per-commit cmd-clickable GitHub URLs (iTerm)
function gf() {
  git log $* --name-status --color | awk "$(cat <<AWK
    /^.*commit [0-9a-f]{40}/ {sha=substr(\$2,1,7)}
    /^[MA]\t/ {printf "%s\t$(gurl)/blob/%s/%s\n", \$1, sha, \$2; next}
    /.*/ {print \$0}
AWK
  )" | less -F
}

# open last commit in GitHub, in the browser.
function gfu() {
  local n="${@:-1}"
  n=$((n-1))
  git web--browse  $(git log -n 1 --skip=$n --pretty=oneline | awk "{printf \"$(gurl)/commit/%s\", substr(\$1,1,7)}")
}

# open current branch + path in GitHub, in the browser.
alias gpu='git web--browse $(gurlp)'

# call from a local repo to open the repository on GitHub/Bitbucket/GitLab in browser
function open_repo() {
  local giturl=$(git config --get remote.origin.url | sed 's/git@/\/\//g' | sed 's/.git$//' | sed 's/https://g' | sed 's/:/\//g')
  if [[ $giturl == "" ]]; then
    echo "Not a git repository or no remote.origin.url is set."
  else
    local gitbranch=$(git rev-parse --abbrev-ref HEAD)
    local giturl="https:${giturl}"
    if [[ $gitbranch != "master" ]]; then
      if echo "${giturl}" | grep -i "bitbucket" > /dev/null ; then
        local giturl="${giturl}/branch/${gitbranch}"
      else
        local giturl="${giturl}/tree/${gitbranch}"
      fi
    fi

    echo $giturl
    git web--browse $giturl
  fi
}
