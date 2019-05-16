# Source global config
[ -f /etc/bash/bashrc ] && source /etc/bash/bashrc

# auto cd to directory by typing its name
shopt -s autocd

# Prompt before removing multiple files and show verbose output
alias rm='rm -I -v'

# Other useful aliases
alias ls='ls --color=auto --group-directories-first'

# Set current tty for gpg-agent
export GPG_TTY=$(tty)

# Set ls colors {{{
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS
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
