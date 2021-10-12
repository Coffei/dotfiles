#!/bin/bash
if playerctl -i chrome,chromium,firefox status &> /dev/null; then
  status=`playerctl -i chrome,chromium,firefox status`
  case $status in
    Paused) 
      status_symbol=
      ;;
    Playing) 
      status_symbol=
      ;;
  esac
  if playerctl -i chrome,chromium,firefox metadata xesam:title &> /dev/null && playerctl -i chrome,chromium,firefox metadata xesam:artist &> /dev/null; then
    title=`exec playerctl -i chrome,chromium,firefox metadata xesam:title`
    artist=`exec playerctl -i chrome,chromium,firefox metadata xesam:artist`
    echo "$status_symbol $title - $artist"
  else
    echo "$status_symbol"
  fi
else
  echo ""
fi
