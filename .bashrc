ource global config
[ -f /etc/bash/bashrc ] && source /etc/bash/bashrc

# auto cd to directory by typing its name
shopt -s autocd

# Convenient package manager aliases
alias sxi='sudo xbps-install'
#alias xi='xbps-install' # Use xi from xtools package
alias sxr='sudo xbps-remove'
#alias xr='xbps-remove'
#alias xq='xbps-query' # Use xq | xrs from xtools package

# Prompt before removing multiple files and show verbose output
alias rm='rm -I -v'

# Other useful aliases
alias ls='ls --color=auto --group-directories-first'

# Set current tty for gpg-agent
export GPG_TTY=$(tty)

# Terminal colors: {{{
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

# Prompt(s): {{{

# Git status, adapted from Spaceship Prompt for Zsh (https://github.com/denysdovhan/spaceship-prompt) {{{
show_git_status() {
	GIT_STATUS_PREFIX=" ["
	GIT_STATUS_SUFFIX="]"
	GIT_STATUS_UNTRACKED="?"
	GIT_STATUS_ADDED="+"
	GIT_STATUS_MODIFIED="!"
	GIT_STATUS_RENAMED=""
	GIT_STATUS_DELETED=""
	GIT_STATUS_STASHED="$"
	GIT_STATUS_UNMERGED="="
	GIT_STATUS_AHEAD="⇡"
	GIT_STATUS_BEHIND="⇣"
	GIT_STATUS_DIVERGED="⇕"
	GIT_STATUS_COLOR="\e[1;31m"

	INDEX=$(git status --porcelain -b 2> /dev/null)
	[[ -z $INDEX ]] && return
	GIT_BRANCH="on \e[1;35m $(echo $INDEX | sed -Ee '/^[^#]/d; s/## ([a-zA-Z0-9_/-]+?).*/\1/')"
	GIT_STATUS=""


	# Check for untracked files
	$(echo "$INDEX" | grep -E '^\?\? ' &> /dev/null) && \
		GIT_STATUS="$GIT_STATUS_UNTRACKED$GIT_STATUS"

	# Check for modified files
	$(echo "$INDEX" | command grep '^[ MARC]M ' &> /dev/null) && \
		GIT_STATUS="$GIT_STATUS_MODIFIED$GIT_STATUS"

	# Check for staged file
	( $(echo "$INDEX" | command grep '^A[ MDAU] ' &> /dev/null) || \
	  $(echo "$INDEX" | command grep '^M[ MD] ' &> /dev/null) || \
	  $(echo "$INDEX" | command grep '^UA' &> /dev/null) ) && \
		GIT_STATUS="$GIT_STATUS_ADDED$GIT_STATUS"

	# Check for renamed files
	$(echo "$INDEX" | command grep '^R[ MD] ' &> /dev/null) && \
		GIT_STATUS="$GIT_STATUS_RENAMED$GIT_STATUS"

	# Check for deleted files
	( $(echo "$INDEX" | command grep '^[MARCDU ]D ' &> /dev/null) || \
	  $(echo "$INDEX" | command grep '^D[ UM] ' &> /dev/null) ) && \
		GIT_STATUS="$GIT_STATUS_DELETED$GIT_STATUS"

	# Check for stashes
	$(command git rev-parse --verify refs/stash >/dev/null 2>&1) && \
		GIT_STATUS="$GIT_STATUS_STASHED$GIT_STATUS"

	# Check for unmerged files
	( $(echo "$INDEX" | command grep '^U[UDA] ' &> /dev/null) || \
	  $(echo "$INDEX" | command grep '^AA ' &> /dev/null) || \
	  $(echo "$INDEX" | command grep '^DD ' &> /dev/null) || \
	  $(echo "$INDEX" | command grep '^[DA]U ' &> /dev/null) ) && \
		GIT_STATUS="$GIT_STATUS_UNMERGED$GIT_STATUS"

	# Check whether branch is ahead
	IS_AHEAD=false
	$(echo "$INDEX" | command grep '^## [^ ]\+ .*ahead' &> /dev/null) && \
		IS_AHEAD=true

	# Check whether branch is behind
	IS_BEHIND=false
	$(echo "$INDEX" | command grep '^## [^ ]\+ .*behind' &> /dev/null) && \
		IS_BEHIND=true

	# Check wheather branch has diverged
	if [[ "$IS_AHEAD" == true && "$IS_BEHIND" == true ]]; then
		GIT_STATUS="$GIT_STATUS_DIVERGED$GIT_STATUS"
	else
		[[ "$IS_AHEAD" == true ]] && GIT_STATUS="$GIT_STATUS_AHEAD$GIT_STATUS"
		[[ "$IS_BEHIND" == true ]] && GIT_STATUS="$GIT_STATUS_BEHIND$GIT_STATUS"
	fi

	# Output final status line
	echo -en $GIT_BRANCH
	[[ -n $GIT_STATUS ]] && echo -en $GIT_STATUS_COLOR$GIT_STATUS_PREFIX$GIT_STATUS$GIT_STATUS_SUFFIX
}
# }}}

export PS1="\n\[\e[1;36m\]\w\[\e[39m\] \$(show_git_status)\[\$(tput sgr0)\]\n "
export PS2="  "
# }}}
