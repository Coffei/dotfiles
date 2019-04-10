#!/bin/bash

if xrandr --query | grep "^DP-1 connected";
then
  sed -i '/Xft.dpi/c\Xft.dpi: 96' $HOME/.Xresources
  sed -i '/dpi = /c\dpi = 96' $HOME/.config/polybar/config
  sed -i '/height = /c\height = 27' $HOME/.config/polybar/config
  xrandr --output eDP-1 --mode 1920x1080 --primary
  xrandr --output DP-1 --pos 1920x0
else
  sed -i '/Xft.dpi/c\Xft.dpi: 196' $HOME/.Xresources
  sed -i '/dpi = /c\dpi = 196' $HOME/.config/polybar/config
  sed -i '/height = /c\height = 54' $HOME/.config/polybar/config
fi

export PATH="$HOME/.cargo/bin:$PATH"
