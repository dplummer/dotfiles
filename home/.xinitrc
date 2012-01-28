#!/bin/sh

setxkbmap -option terminate:ctrl_alt_bksp
xsetroot -cursor_name left_ptr
xset r rate 200 30
#xmonad

#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

exec ck-launch-session startxfce4
