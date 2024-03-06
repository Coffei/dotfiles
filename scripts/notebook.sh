#!/bin/bash
sed -i '/dpi = /c\dpi = 192' $HOME/.config/polybar/config.ini
sed -i '/height = /c\height = 48' $HOME/.config/polybar/config.ini
gsettings set org.gnome.desktop.interface text-scaling-factor 1.0
