#!/bin/bash

SRC="~/Downloads/unrared/"
DST="~/Downloads/iPhone-movies/"
EXT="mp4"
PRESET="iPhone & iPod Touch"
RM_SRC="true"

find $SRC -type f | while read line
do
 outfile="$(basename "$line")-iPhone.$EXT"
 if [ ! -e "$DST/$outfile" ]; then
  echo ""  | HandBrakeCLI --preset="$PRESET" -i "$line" -o "$DST/$outfile"
  if [ "$RM_SRC" ]; then trash "$line" ;fi
 fi
done
