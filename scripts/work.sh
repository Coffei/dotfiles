#!/bin/bash
sed -i '/dpi = /c\dpi = 96' $HOME/.config/polybar/config
sed -i '/height = /c\height = 27' $HOME/.config/polybar/config
gsettings set org.gnome.desktop.interface text-scaling-factor 1.0
