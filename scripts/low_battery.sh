#!/bin/bash
PATH=/usr/bin:/bin

echo "hello world"
BATTINFO=`acpi -b`
# if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 5 -d " "` < 00:30:00 ]] ; then
    echo "hello world 111"
    export DISPLAY=:0.0 && /usr/bin/notify-send "low battery" "$BATTINFO"
  # else
    echo "hello world 222"
# fi
