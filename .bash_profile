export HISTCONTROL=ignoredups:erasedups  
shopt -s histappend

export PROMPT_COMMAND="history -a; history -c; history -r"

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

alias ls="ls -lahG"
