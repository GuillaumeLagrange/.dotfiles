#bin/sh

# Check if spotify is currently playing
if [ "$(pidof spotify)" ]; then
    status=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' | grep -c Playing)`

    # Pause spotify
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause
fi

# Lock computer
i3lock -c 202020 -n

# Play spotify if it was previously playing
if [ $status = 1 ]; then
  dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play
fi
