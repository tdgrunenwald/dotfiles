# ~/.xinitrc

# merge settings in Xresources
[ -f ~/.Xresources ] && xrdb -I $HOME -merge ~/.Xresources

# set background
[ -f ~/.fehbg ] && ~/.fehbg &

# load custom keybindings for non DE specific things e.g. media keys
[ -f ~/.config/xbindkeys/config ] && xbindkeys -f ~/.config/xbindkeys/config

# ctrl+alt+bksp to kill X
setxkbmap -option terminate:ctrl_alt_bksp

# set monitor profile
autorandr --change --default undocked

# start i3 window manager
exec i3
