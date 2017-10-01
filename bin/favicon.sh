#!/bin/sh
# from http://dailyraisin.com/logo-to-favicon-automation/
# apt/brew install imagemagick pngcrush
# TODO:測試其他圖片壓縮工具，如 OptiPNG 或 Guetzli。
if [ $# -ne 1 ]; then  
  echo 'Usage: favicon.sh [src.png]';
  exit 0;
fi;

SRC=$1

for DIM in 16 32 64 144 152 180 192
do
    convert -resize ${DIM}x${DIM}^ ${SRC} tmp-favicon-${DIM}.png
    pngcrush -rem allb -brute -reduce tmp-favicon-${DIM}.png tmp-favicon-${DIM}-crushed.png
    mv tmp-favicon-${DIM}-crushed.png ${SRC}-${DIM}.png
done

for DIM in 16 32 64 144 152 180 192
do
    rm tmp-favicon-${DIM}.png
done
