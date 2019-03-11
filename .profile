# ~/.profile

# Include definitions from bashrc
source ~/.bashrc

# Make less more secure
export LESSHISTFILE=-
export LESSSECURE=1
export LESSOPEN=""

# Add scripts to path
export PATH=$PATH:$HOME/.scripts:$HOME/.local/bin

# Set default programs
export EDITOR="vim"
export BROWSER="firefox"

# Set CUPS default printer
export PRINTER="HL-L2360DW"

# Start X on tty1
if [ $(tty) == "/dev/tty1" ]; then
	startx
	exit 0
fi
