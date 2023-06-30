#!/bin/bash
sed -i '/dpi = /c\dpi = 192' $HOME/.config/polybar/config
sed -i '/height = /c\height = 48' $HOME/.config/polybar/config
gsettings set org.gnome.desktop.interface text-scaling-factor 1.0
