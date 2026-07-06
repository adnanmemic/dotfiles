# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#### ENVIRONMENT 
export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTCONTROL=ignoreboth
export PAGER=less
export EDITOR=nvim
export VISUAL=nvim
export GREP_COLORS='ms=1;31' # red

export GROFF_NO_SGR=1

export LESS_TERMCAP_md=$'\e[1;38;5;210m' # bold + red
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33;44m' # highlight + yellow + blue background
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;38;5;157m' # underline + green
export LESS_TERMCAP_ue=$'\e[0m'

#### PATH
export PATH=$PATH:/usr/local/go/bin

export JAVA_HOME=/usr/local/java/jdk-23.0.2
export PATH=$JAVA_HOME/bin:$PATH

export MAVEN_HOME=/usr/local/maven/apache-maven-3.9.11
export PATH=$MAVEN_HOME/bin:$PATH

export PATH=$PATH:~/bin

export PATH=$PATH:/usr/local/nvim/12.2

export PATH=$PATH:/usr/local/texlive/2026/bin/x86_64-linux

#### SHELL OPTIONS
shopt -s histappend
shopt -s cdspell
shopt -s checkwinsize
shopt -s dirspell

#### ALIASES
alias bat='batcat --pager=cat'

# enable color support for grep (if possible)
if printf 'x\n' | grep --color=auto x &>/dev/null; then
	alias grep='grep --color=auto'
fi

# enable color support of ls
if ls --color=auto &>/dev/null; then
	alias ls='ls -p --color=auto'
else
	alias ls='ls -p -G'
fi

##### PROMPT
# (exitcode) <user> - <hostname> hh:MM:ss <cwd> $

# exitcode - color: red
PS1='$(exit=$?; (($exit != 0)) && printf "\[\e[38;5;210m($exit) \e[0m\]")'

# user - color: blue
PS1+='\[\e[38;5;81m\]\u\[\e[0m\] - '

# hostname - color: blue
PS1+='\[\e[38;5;81m\]\h\[\e[0m\] '

# time - color: orange
PS1+='\[\e[38;5;215m\]\t\[\e[0m\] '

# pwd - color: green
PS1+='\[\e[38;5;157m\]\w\[\e[0m\] '

# prompt character - color: blue
PS1+='\[\e[38;5;81m\]\$\[\e[0m\] '

#### XTRACE 
# [debug] (linenumber)

PS4='\e[31m[debug]\e[0m '

PS4+='\e[36m($LINENO)\e[0m '

#### LOAD EXTERNAL FILES
. $HOME/.bash_aliases 2>/dev/null

# load completion
. /usr/share/bash-completion/bash_completion 2>/dev/null || 
	. /etc/bash_completion 2>/dev/null

#### MINICONDA
conda() {
	unset -f conda

	# >>> conda initialize >>>
	# !! Contents within this block are managed by 'conda init' !!
	__conda_setup="$("$HOME/miniconda3/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
	if [ $? -eq 0 ]; then
	    eval "$__conda_setup"
	else
	    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
			. "$HOME/miniconda3/etc/profile.d/conda.sh"
	    else
			export PATH="$HOME/miniconda3/bin:$PATH"
	    fi
	fi
	unset __conda_setup
	# <<< conda initialize <<<
	
	conda "$@"
}
