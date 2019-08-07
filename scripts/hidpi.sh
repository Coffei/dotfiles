#!/bin/bash
# Changes DPI to HIGH, sets scaling to ~2x. Automates all changes that need to be done to change
# DPI/scaling reliably on my setup.

# Target DPI, hardcoded below
dpi=192

# For applications supporting XSettings, `Xft/DPI' sets font scaling
# (and sometimes interface scaling), `Gdk/WindowScalingFactor' sets
# interface scaling with GTK 3, and `Gdk/UnscaledDPI' undo font scaling
# for GTK 3 applications.
cat <<'EOF' > ~/.xsettingsd
Xft/DPI 196608
Gdk/WindowScalingFactor 2
Gdk/UnscaledDPI 98304
EOF
pkill -HUP xsettingsd || xsettingsd &

# For QT applications.
export QT_AUTO_SCREEN_SCALE_FACTOR=1

# For miscellaneous applications.
echo Xft.dpi: $dpi | xrdb -merge

sed -i '/dpi = /c\dpi = 192' $HOME/.config/polybar/config
sed -i '/height = /c\height = 54' $HOME/.config/polybar/config
