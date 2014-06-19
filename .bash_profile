export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=10000
shopt -s histappend

export PROMPT_COMMAND="history -n; history -w; history -c; history -r"
export EDITOR=vim
export PS1="\u@\h: \w$ "

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

alias ls="ls -lahG"
alias s="git status"
alias myip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([1-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"

upgrade_casks() {
    old_ifs=$IFS
    IFS=$'\n'
    for cask in $(brew cask list)
    do
        caskname=$(awk '{ print $1 }' <<< $cask)
        if grep '(!)$' <<< $cask >/dev/null
        then
            echo "warning: the installed cask $caskname seems to be" \
                "unavailable in homebrew-cask, has it been renamed?" && continue
        fi
        if brew cask info $cask | grep -qiF 'Not installed'
        then
            echo "--> upgrading cask $cask"
            brew cask uninstall $cask
            brew cask install $cask
        fi
    done
    brew cask cleanup
    IFS=$old_ifs
}

pupdate() {
    bupdate
    upgrade_casks
}

bupdate() {
    for action in update doctor upgrade cleanup
    do
        echo "--> brew $action" && brew $action
    done
}



