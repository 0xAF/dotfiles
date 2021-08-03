#!/bin/sh

# start xbindkeys daemon
xbindkeys -p

# configure xmodmap
xmodmap ~/.xmodmap

# disable touchpad horizontal scroll
xinput set-prop "DELL0825:00 06CB:7E92 Touchpad" 307 0


