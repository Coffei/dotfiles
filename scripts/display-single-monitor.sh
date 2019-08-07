#!/bin/bash
# Change monitor layout to single-NTB monitor. Disconnect all other monitors and set the NTB display
# to full resolution. This changes DPI to HIGH.

xrandr --output DP1 --off --output DP2 --off
xrandr --output eDP1 --mode 3200x1800
hidpi
i3-msg restart
sleep 1
~/.config/polybar/launch-all.sh
