#!/bin/bash
if playerctl status &> /dev/null; then
  status=`playerctl -i chrome status`
  case $status in
    Paused) 
      status_symbol=
      ;;
    Playing) 
      status_symbol=
      ;;
  esac
  title=`exec playerctl -i chrome metadata xesam:title`
  artist=`exec playerctl -i chrome metadata xesam:artist`
  echo "$status_symbol $title - $artist"
else
  echo ""
fi
