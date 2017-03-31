#!/usr/bin/env zsh
#
# print available colors and their numbers
#
# - https://github.com/loliee/dotfiles/blob/master/.aliases
# - https://github.com/ahmedelgabri/dotfiles/blob/master/zsh/config/functions/colors.zsh
function colors() {
  for code in $(seq -w 0 255); do for attr in 0 1;
    do printf "%s-%03s %b■■■■%b\n" "${attr}" "${code}" "\e[${attr};38;05;${code}m" "\e[m";
  done; done | column -c $((COLUMNS*2))
}

function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f"
  done
}

function spectrum_bls() {
  for code in {000..255}; do
    ((cc = code + 1))
    print -P -- "$BG[$code]$code: Test %{$reset_color%}"
  done
}

# 000 .. 250
function colorgrid() {
  iter=16
  while [ $iter -lt 52 ]
  do
    second=$[$iter+36]
    third=$[$second+36]
    four=$[$third+36]
    five=$[$four+36]
    six=$[$five+36]
    seven=$[$six+36]
    if [ $seven -gt 250 ];then seven=$[$seven-251]; fi

    echo -en "\033[38;5;$(echo $iter)m█ "
    printf "%03d" $iter
    echo -en "   \033[38;5;$(echo $second)m█ "
    printf "%03d" $second
    echo -en "   \033[38;5;$(echo $third)m█ "
    printf "%03d" $third
    echo -en "   \033[38;5;$(echo $four)m█ "
    printf "%03d" $four
    echo -en "   \033[38;5;$(echo $five)m█ "
    printf "%03d" $five
    echo -en "   \033[38;5;$(echo $six)m█ "
    printf "%03d" $six
    echo -en "   \033[38;5;$(echo $seven)m█ "
    printf "%03d" $seven

    iter=$[$iter+1]
    printf '\r\n'
  done
}
