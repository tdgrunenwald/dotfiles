# ~/.zprofile

# include definitions from zshrc
source ~/.zshrc

# make less more secure
export LESSHISTFILE=-
export LESSSECURE=1
export LESSOPEN=""

# add scripts to path
export PATH="$PATH:$HOME/.scripts:$HOME/.local/bin"

# set default editor
export EDITOR="vim"

# set CUPS default printer
export PRINTER="HL-L2360DW"

# start X on tty1
[ $(tty) = "/dev/tty1" ] && startx; exit 0

