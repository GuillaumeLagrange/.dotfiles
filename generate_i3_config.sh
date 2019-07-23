#!/bin/sh

mkdir -p ~/.config ~/.config/i3
cat i3/config_common i3/config_local > ~/.config/i3/config
