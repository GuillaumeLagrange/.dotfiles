#/bin/sh

# Suspend notification display
pkill -u "$USER" -USR1 dunst

playerctl pause

# Lock computer
swaylock -c 202020 -n

# Resume notification display
pkill -u "$USER" -USR2 dunst
