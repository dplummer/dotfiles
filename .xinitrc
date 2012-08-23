# bind caps lock to esc
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Control = Control_L"

xsetroot -cursor_name left_ptr
xset r rate 200 30 &
/usr/bin/xscreensaver -no-splash &
xmonad
