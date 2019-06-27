# ~/.xinitrc

# ctrl+alt+bksp to kill X
setxkbmap -option terminate:ctrl_alt_bksp

# hide mouse cursor after a few idle seconds
unclutter -idle 2 -root -grab &

# set monitor profile
autorandr --change --force --default undocked

# merge settings in Xresources
[ -f ~/.Xresources ] && xrdb -I $HOME -merge ~/.Xresources

# set background
[ -f ~/.fehbg ] && ~/.fehbg

# load custom keybindings for non DE specific things e.g. media keys
[ -f ~/.config/xbindkeys/config ] && xbindkeys -f ~/.config/xbindkeys/config

# start i3 window manager
exec i3
