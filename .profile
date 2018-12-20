# ~/.profile

# include definitions from bashrc
source ~/.bashrc

# make less more secure
export LESSHISTFILE=-
export LESSSECURE=1
export LESSOPEN=""

# add scripts to path
export PATH=$PATH:$HOME/.scripts
