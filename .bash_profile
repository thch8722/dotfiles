export HISTCONTROL=ignoredups:erasedups  
shopt -s histappend

export PROMPT_COMMAND="history -a; history -c; history -r"
export EDITOR=vim

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

alias ls="ls -lahG"
alias s="git status"

bupdate() {
    for action in update upgrade cleanup
    do
        echo "--> $action" && brew $action
    done
}
