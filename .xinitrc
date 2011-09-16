#!/bin/sh
# ~/.xinitrc

# Wallpaper
feh --bg-scale ~/pics/background.jpg &

# Start programs
urxvtd -q -o -f &
xbindkeys &
xbacklight -set 100 &
xmodmap ~/.Xmodmap &
#unclutter &
amixer set Master 80% &
#prowler &
bitlbee -D
#synergyc -- 192.168.0.15
dropboxd &
#touchpad &

xset +fp /usr/share/fonts/local
xset fp rehash

#conky | while read -r; do xsetroot -name "$REPLY"; done &
#/home/scheibo/dxconky &
#exec dwm

while true; do
    xsetroot -name "`date '+%H:%M:%S'`"
    sleep 1
done &
exec dwm # Start the window manager


