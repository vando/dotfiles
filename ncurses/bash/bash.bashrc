# System-wide .bashrc file for interactive bash(1) shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ `id -u` -gt 0 ]
then
    COLOR="\[\e[0;36m\]"
fi

PS1="${COLOR:-\[\e[0;35m\]}\h:\W \$>\[\e[0m\] "
PS2="> "
export PS1 PS2

export LANG=en_US.UTF-8 
export LC_CTYPE=en_US.UTF-8
export EDITOR=jed
export HISTIGNORE="clear:exit:halt:ls:pwd:reboot:reset:resource:shutdown:cd:bc"
export HISTCONTROL="ignoreboth:erasedups"
export HISTFILESIZE="999999"

set completion-ignore-case on 
shopt -s cdspell checkhash no_empty_cmd_completion hostcomplete

complete -cf alias info man whereis which

export LESSOPEN="|lesspipe.sh %s"
export LESS_TERMCAP_mb=$'\E[0;31m'
export LESS_TERMCAP_md=$'\E[0;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

if [ `uname -s` = "Linux" ]
then    
    alias dff='df -hx tmpfs | column -t'
    alias ls='ls -1Aq --color=always --file-type --group-directories-first'
    alias poweroff='sudo /sbin/poweroff'
    alias bc='bc -q'
else
    alias halt='shutdown -hp now'
    alias dff='df -h'
    alias ls='colorls -1AGq'
fi

alias lsw='tmux lsw -F "#{window_index}#{window_flags}#{window_name}"'

if [ `id -u` -eq 0 ]
then
    dhcp()
    {
        if [ "$#" -lt 1 ]
        then
            echo -e "Usage:\n\tdhcp <up|down> iface"
	    exit 1
	 fi
	 
	 case ${1} in
	     up)   dhcpcd -t 10 ${2} ;;
	     down) dhcpcd -k ${2} ;;
	     *) echo "Wrong option: \"$1\"" && exit 1 ;;
	 esac
    }
fi

[ -d ${HOME}/bin ] && export PATH=$PATH:$HOME/bin