#!/bin/sh

SINK=$(pactl list short | grep bluez_card | cut -f1)
pactl set-card-profile $SINK a2dp_sink
