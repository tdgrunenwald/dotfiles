# ~/.bashrc

# source global config
[ -f /etc/bash/bashrc ] && source /etc/bash/bashrc

# auto cd to directory by typing its name
shopt -s autocd

# convenient package manager aliases
alias sxi='sudo xbps-install'
alias xi='xbps-install'
alias sxr='sudo xbps-remove'
alias xr='xbps-remove'
alias xq='xbps-query'

# prompt before removing multiple files and show verbose output
alias rm='rm -I -v'

# other useful aliases
alias ls='ls --color=auto --group-directories-first'

# set current tty for gpg-agent
export GPG_TTY=$(tty)

# custom PS1 with time and git branch
export PS1="\[\e[1;30;40m\]\T \[\e[1;37;40m\]\u@\h \W\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')\[\$(tput sgr0)\]\n\\\$ "
