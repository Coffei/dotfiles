#!/bin/sh

# volume=$(pacmd list-sources | grep "\* index:" -A 7 | grep "volume" | awk -F/ '{print $2}')
mute=$(pactl list sources | grep 'api.alsa.pcm.stream = "capture"' -B 11 | grep 'Mute: yes')
# volume=$(pacmd list-sources | grep "$1" -A 6 | grep "volume" | awk -F/ '{print $2}')
# mute=$(pacmd list-sources | grep "$1" -A 11 | grep "muted" )

if [[ "$mute" == *"yes"* ]]; then
  echo -e '\Uf131'
else
  echo -e '\Uf130'
fi
