#/bin/sh

# Get current media player name
MPRIS_TARGET=`dbus-send --session --dest=org.freedesktop.DBus --type=method_call --print-reply=literal /org/freedesktop/DBus org.freedesktop.DBus.ListNames | tr ' ' '\n' | grep 'org.mpris.MediaPlayer2.mps-youtube' | head -n 1`
if [ -z $MPRIS_TARGET ]; then
  MPRIS_TARGET=`dbus-send --session --dest=org.freedesktop.DBus --type=method_call --print-reply=literal /org/freedesktop/DBus org.freedesktop.DBus.ListNames | tr ' ' '\n' | grep 'org.mpris.MediaPlayer2.spotify' | head -n 1`
fi

# Check if media player is currently playing
if [ ! -z "$MPRIS_TARGET" ]; then
    status=`dbus-send --print-reply --dest=$MPRIS_TARGET /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' | grep -c Playing)`

    # Pause media player
    dbus-send --print-reply --dest=$MPRIS_TARGET /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause
fi

# Lock computer
i3lock -c 202020 -n

# Play media player if it was previously playing
if [ $status = 1 ]; then
  dbus-send --print-reply --dest=$MPRIS_TARGET /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play
fi
