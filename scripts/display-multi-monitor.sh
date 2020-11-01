#!/bin/bash
# Change monitor layout to work setup - two monitors side-by-side. This scales NTB monitor to FullHD
# (so it matches the DPI of the other monitor) and changes DPI to LOW.

lodpi
sleep 1
xrandr --output eDP-1 --mode 1920x1080
xrandr --output DP-1 --auto --right-of eDP-1
sleep 1
i3-msg restart
# ~/.config/polybar/launch-all.sh
pkill dunst && dunst &
