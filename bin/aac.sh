#!/bin/sh
# from https://gist.github.com/candycode/3c3472ff83e9d587282c
#      https://askubuntu.com/a/668106
for i in *.mp4; do
  echo -e "\033[46m Converting $i \033[0m";
  k=`echo $i | tr ' ' '_'`;
  cp "$i" "$k";
  f=`basename $k .mp4`;
  ffmpeg -i $k -acodec copy -vn $f.aac || echo FAILED;
  rm $k;
done
