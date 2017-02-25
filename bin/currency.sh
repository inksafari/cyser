#!/usr/bin/env bash

# Currency converter
# https://github.com/claudiosanches/dotfiles/blob/master/bin/currency

if [[ "$#" != 3 || "$1" == "-h" || "$1" == "--help" ]] ; then cat <<HELP
Currency converter.

Usage:
currency.sh [amouth] [from] [to]

Example:
currency.sh 1 USD TWD
HELP
exit; else
  wget -qO- "http://www.google.com/finance/converter?a=$1&from=$2&to=$3" | sed '/res/!d;s/<[^>]*>//g';
fi
