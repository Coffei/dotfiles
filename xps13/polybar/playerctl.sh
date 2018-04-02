#!/bin/bash
if playerctl status &> /dev/null; then
  status=`playerctl status`
  case $status in
    Paused) 
      status_symbol=
      ;;
    Playing) 
      status_symbol=
      ;;
  esac
  title=`exec playerctl metadata xesam:title`
  artist=`exec playerctl metadata xesam:artist`
  echo "$status_symbol $title - $artist"
else
  echo ""
fi
