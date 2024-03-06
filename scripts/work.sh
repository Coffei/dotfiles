#!/bin/bash
sed -i '/dpi = /c\dpi = 96' $HOME/.config/polybar/config.ini
sed -i '/height = /c\height = 27' $HOME/.config/polybar/config.ini
gsettings set org.gnome.desktop.interface text-scaling-factor 1.0
