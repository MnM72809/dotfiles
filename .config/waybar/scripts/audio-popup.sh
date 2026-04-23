#!/usr/bin/env bash

current=$(wpctl status | awk '/\*.*Sink/ {print $2}')

wpctl status |
  awk '
  /Sinks:/ {flag=1; next}
  /Sources:/ {flag=0}
  flag && /^\s+[0-9]+\./ {
    id=$1
    sub(/\./,"",id)
    vol="?"
    name=$0
    sub(/.*\] /,"",name)
    print id "|" name
  }' |
  while IFS="|" read -r id name; do
    vol=$(wpctl get-volume "$id" | awk "{print int(\$2*100)}")
    prefix="  "
    [[ "$id" == "$current" ]] && prefix="▶ "
    echo "$prefix$name [$vol%]"
  done |
  rofi -dmenu -i -p "Audio output"

