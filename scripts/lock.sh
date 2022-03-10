#/bin/sh

# Check if media player is currently playing
status=`playerctl status`
playerctl pause

# Lock computer
i3lock -c 202020 -n

# Play media player if it was previously playing
if [ $status = "Playing" ]; then
  playerctl play
fi
