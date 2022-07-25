# 0xAF: my personal (user) bashrc

if [[ $- != *i* ]]; then
	# Shell is non-interactive.  Be done now
	return
fi

# sensitive data
if [[ -f ~/.bashrc.system ]]; then
	source ~/.bashrc.system
fi

source /usr/lib/homeshick/homeshick.sh

function exists() { type -P $1 >/dev/null 2>&1; }

if [ -f ~/.lessfilter ]; then
	export LESSOPEN="|~/.lessfilter %s"
fi

if [[ -f ~/.config/dircolors/LS_COLORS ]]; then
	eval `dircolors -b ~/.config/dircolors/LS_COLORS`
else
	eval `dircolors -b`
fi

#if [ -n $DISPLAY ]; then
	#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/$HOME/~}    | \007"'
	#export COLORTERM=truecolor
#fi

case $TERM in
	xterm*|rxvt*|Eterm)
		#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen*)
		#PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

#if exists keychain; then
#	eval $( keychain --eval --agents ssh,gpg --inherit any -Q ~/.ssh/id_rsa ~/.ssh/github_rsa ~/.ssh/bitbucket_rsa ~/.ssh/git.0xaf.org_rsa A8B855BD DA3BB96F)
#fi

#unset SSH_AGENT_PID
#if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
#	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
#fi
#
#export GPG_TTY=$(tty)
#gpg-connect-agent updatestartuptty /bye >/dev/null

#ssh-add ~/.ssh/id_rsa ~/.ssh/github_rsa ~/.ssh/bitbucket_rsa ~/.ssh/git.0xaf.org_rsa

bashquote() { printf '%q\n' "$(cat)" ; }

exists fortune && fortune -ac

# aliases
#alias ssh='ssh -e\|'
alias ls="$(type -P ls) --color=auto --group-directories-first -p"
#alias ll="$(type -P ls) --color=auto --group-directories-first -p -la"
#exists exa      && alias ls="$(type -P exa) --color=auto -F --group-directories-first --color-scale -g"
alias grep="$(type -P grep) --color=auto"

exists qrencode && alias qr='qrencode -t ANSIUTF8 -o -'

#make-debug print-SOURCE_FILES
alias make-debug='make --eval="print-%: ; @echo $*=$($*)"'

alias config='/usr/bin/git --git-dir=$HOME/.config/dotfiles.git/ --work-tree=$HOME'
alias config_private='/usr/bin/git --git-dir=$HOME/.config/dotfiles_private.git/ --work-tree=$HOME'

alias sync_caches='grep -e Dirty: -e Writeback: /proc/meminfo'

export PATH=~/bin:~/.local/bin:~/.local/sbin:$PATH:/sbin:/usr/sbin

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# gopass
if exists gopass; then
	source <(gopass completion bash)
fi

if [[ -n $TMUX ]]; then
	#echo "setting alternate screen"
	tmux set alternate-screen off

	#echo -ne '\e[?1049h' # Enable alternative screen buffer, from xterm
	#echo -ne '\e[?1049l' # Disable alternative screen buffer, from xterm
fi


exists zssh && alias ssh=zssh
alias ssh-ignore='ssh -- -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o IdentitiesOnly=yes '

# sensitive data
if [[ -f ~/.bashrc.local ]]; then
	source ~/.bashrc.local
fi

exists starship && eval "$(starship init bash)"

unset -f exists

