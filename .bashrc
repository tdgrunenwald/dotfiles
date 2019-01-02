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

# Set terminal colors: {{{
# adapded from Chris Kempson's base 16 shell (I'd didn't care for the use of 256 color space)
# mocha dark theme from https://terminal.sexy
color00="3b/32/28"
color01="cb/60/77"
color02="be/b5/5b"
color03="f4/bc/87"
color04="8a/b3/b5"
color05="a8/9b/b9"
color06="7b/bd/a4"
color07="d0/c8/c6"
color08="7e/70/5a"
color09="cb/60/77"
color10="be/b5/5b"
color11="f4/bc/87"
color12="8a/b3/b5"
color13="a8/9b/b9"
color14="7b/bd/a4"
color15="f5/ee/eb"

if [ -n "$TMUX" ]; then
	# Tell tmux to pass the escape sequences through
	# (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
	put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
	# GNU screen (screen, screen-256color, screen-256color-bce)
	put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
	put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
else
	put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
fi

put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

unset -f put_template
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
clear
# }}}

# custom PS1 with time and git branch
export PS1="\[\e[1;30;40m\]\T \[\e[1;37;40m\]\u@\h \W\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')\[\$(tput sgr0)\]\n\\\$ "
