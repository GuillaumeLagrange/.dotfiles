#!/bin/sh

# Get current media player name
MPRIS_TARGET=`dbus-send --session --dest=org.freedesktop.DBus --type=method_call --print-reply=literal /org/freedesktop/DBus org.freedesktop.DBus.ListNames | tr ' ' '\n' | grep 'org.mpris.MediaPlayer2.mps-youtube' | head -n 1`
if [ -z $MPRIS_TARGET ]; then
  MPRIS_TARGET=`dbus-send --session --dest=org.freedesktop.DBus --type=method_call --print-reply=literal /org/freedesktop/DBus org.freedesktop.DBus.ListNames | tr ' ' '\n' | grep 'org.mpris.MediaPlayer2.spotify' | head -n 1`
fi

# Play/payse media player
if [ ! -z "$MPRIS_TARGET" ]; then
  dbus-send --print-reply --dest=$MPRIS_TARGET /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
fi
