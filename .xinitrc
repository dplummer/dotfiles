# bind caps lock to esc
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Escape"
xmodmap -e "add Control = Control_L"

xsetroot -cursor_name left_ptr
xset r rate 200 30 &
xmonad
