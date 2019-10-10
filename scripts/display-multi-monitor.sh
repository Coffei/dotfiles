#!/bin/bash
# Change monitor layout to work setup - two monitors side-by-side. This scales NTB monitor to FullHD
# (so it matches the DPI of the other monitor) and changes DPI to LOW.

xrandr --output eDP1 --mode 1920x1080
xrandr --output DP1 --auto --right-of eDP1
sleep 1
lodpi
i3-msg restart
sleep 1
~/.config/polybar/launch-all.sh
pkill dunst && dunst &
