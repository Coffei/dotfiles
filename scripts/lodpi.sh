#!/bin/bash
# Changes DPI to LOW, sets scaling to 1x. Automates all changes that need to be done to change
# DPI/scaling reliably on my setup.

# Target DPI, hardcoded below
dpi=96

# For applications supporting XSettings, `Xft/DPI' sets font scaling
# (and sometimes interface scaling), `Gdk/WindowScalingFactor' sets
# interface scaling with GTK 3, and `Gdk/UnscaledDPI' undo font scaling
# for GTK 3 applications.
cat <<'EOF' > ~/.xsettingsd
Xft/DPI 98304
Gdk/WindowScalingFactor 1
Gdk/UnscaledDPI 98304
EOF
pkill -HUP xsettingsd || xsettingsd &

# For QT applications.
export QT_AUTO_SCREEN_SCALE_FACTOR=1

# For miscellaneous applications.
echo Xft.dpi: $dpi | xrdb -merge

# These are still valid even if gnome handles the scaling
sed -i '/dpi = /c\dpi = 96' $HOME/.config/polybar/config.ini
sed -i '/height = /c\height = 27' $HOME/.config/polybar/config.ini
