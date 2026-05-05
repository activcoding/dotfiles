#!/usr/bin/env bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" background.drawing=true icon.color=0xfff7f1ff
else
  sketchybar --set "$NAME" background.drawing=false icon.color=0xff8b888f
fi
