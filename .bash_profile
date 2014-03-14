export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=10000
shopt -s histappend

export PROMPT_COMMAND="history -n; history -w; history -c; history -r"
export EDITOR=vim

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

alias ls="ls -lahG"
alias s="git status"

upgrade_casks() {
    for cask in $(brew cask list)
    do
        brew cask install $cask
    done
    brew cask cleanup
}

bupdate() {
    for action in update doctor upgrade cleanup
    do
        echo "--> brew $action" && brew $action
    done
    upgrade_casks
}

hr() {
    printf -- "${1:-=}%.0s" $(seq $COLUMNS)
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
