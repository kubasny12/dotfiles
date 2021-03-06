#!/bin/bash

toggle="playerctl play-pause"
next="playerctl next"
prev="playerctl previous"
run="spotify"
stop="killall spotify"

status=`playerctl status`

PIDS=`pidof spotify | gawk '{print NF}'`

if [ "$PIDS" == '' ]; then
  PIDS=0
fi

if [ "$PIDS" -gt "3" ] ;  then
  meta=`playerctl metadata`
  title=`grep 'title' <<< "$meta" | awk '{$1=""}{$2=""}{print $0}' | cut -c 3-`
  albumArtist=` grep 'albumArtist' <<< "$meta" | awk '{$1=""}{$2=""}{print $0}' | cut -c 3-`
  fname="$albumArtist - $title"
  out="%{A2:$stop:}%{A1:$toggle:}%{A4:$next:}%{A5:$prev:}$fname%{A}%{A}%{A}%{A}"
fi

if [ "$status" == "Playing" ]; then
  out="%{F#FFFFFF}$out%{F-}"
fi

echo "$out" > ./scripts/Read/player
