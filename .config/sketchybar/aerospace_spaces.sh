#!/usr/bin/env bash
FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null | tr -d '[:space:]')
for sid in 1 2 3 4 5 6 7 8 9; do
  if [ "$sid" = "$FOCUSED" ]; then
    sketchybar --set "space.$sid" icon.color=0xfff7f1ff background.drawing=true
  else
    sketchybar --set "space.$sid" icon.color=0xff8b888f background.drawing=false
  fi
done
