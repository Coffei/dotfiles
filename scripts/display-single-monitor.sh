#!/bin/bash
# Change monitor layout to single-NTB monitor. Disconnect all other monitors and set the NTB display
# to full resolution. This changes DPI to HIGH.

hidpi
sleep 1
xrandr --output DP-1 --off --output DP-2 --off
xrandr --output eDP-1 --mode 3200x1800
sleep 1
i3-msg restart
# ~/.config/polybar/launch-all.sh
pkill dunst && dunst &
