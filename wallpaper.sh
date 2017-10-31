#!/bin/bash
while getopts d: option
do
 case "${option}"
 in
 d) DIR=$OPTARG;;
 esac
done


URL=$(wget -O - http://www.reddit.com/r/wallpapers.rss | grep -Eo "https://?[^&]+jpg" | grep -v "thumbs" | head -1);
NAME=$(basename "$URL");

if [ "$DIR" ]
  then
    FILENAME="$DIR""$NAME";
  else
    FILENAME=~/Pictures/"$NAME";
fi

wget "$URL" -O "$FILENAME";
sleep 1;
gsettings set org.gnome.desktop.background picture-uri nothing;
gsettings set org.gnome.desktop.background picture-uri file://"$FILENAME";
