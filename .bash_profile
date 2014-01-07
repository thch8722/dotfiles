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
        echo "--> brew $action" && brew $action
    done
}

get_source_dir() {
    source="${BASH_SOURCE[0]}"
    # resolve $source until the file is no longer a symlink
    while [ -h "$source" ]; do
        dir="$( cd -P "$( dirname "$source" )" && pwd )"
        source="$(readlink "$source")"
        # if $source was a relative symlink, we need to resolve it relative to
        # the path where the symlink file was located
        [[ $source != /* ]] && source="$dir/$source"
    done
    dir="$( cd -P "$( dirname "$source" )" && pwd )"
    echo "$dir"
}
source $(get_source_dir)/lib/git-prompt/git-prompt
export PS1="\$(git_prompt)"$PS1
