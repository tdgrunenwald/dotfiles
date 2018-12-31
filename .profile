# ~/.profile

# include definitions from bashrc
source ~/.bashrc

# make less more secure
export LESSHISTFILE=-
export LESSSECURE=1
export LESSOPEN=""

# add scripts to path
export PATH=$PATH:$HOME/.scripts

# set default editor
export EDITOR="vim"

# set CUPS default printer
export PRINTER="HL-L2360DW"

# start X on tty1
if [ $(tty) == "/dev/tty1" ]; then
	startx
	exit 0
fi
