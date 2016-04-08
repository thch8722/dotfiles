export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=10000
shopt -s histappend

export PROMPT_COMMAND="history -n; history -w; history -c; history -r"
export EDITOR=vim
export PS1="\u@\h: \w$ "
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_80.jdk/Contents/Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_71.jdk/Contents/Home

export HOMEBREW_GITHUB_API_TOKEN=58cad501e3168c32bccd12cc41c04fa3786e634e

export MAVEN_OPTS="-server -Xmx3g -XX:MaxPermSize=256m"
export JAVA_OPTS="-server -Xmx3g -XX:MaxPermSize=256m -Dpolopoly.ejb-configuration.db.autoInstall=true"
# export JAVA_OPTS="-server -Xmx3g -XX:MaxPermSize=256m"
export JBOSS_HOME=/Users/thch8722/polopoly/work/embedded-jboss

source ~/.profile

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

alias ls="ls -lahG"
alias s="git status"
alias myip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias pu="cd ~ && clear"
alias which='type -all'

alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'


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

ptimer() {
re='^[0-9]+$'
if ! [[ $1 =~ $re ]] ; then
  echo "    ptimer2 takes three input parameters: time, message and button text. 
    Example usage: ptimer2 2 \"Time for a break!\" \"Yes, that is a good idea\" 
    sets a two minutes timer with message \"Time for a break!\" with button \"Yes, that is a goo idea.\""
else
echo "timer set for $1 minutes with the message \"$2\" and button \"$3\""
    exec 3>&1
    mkdir -p ~/.bash_profile_logs
    exec 1>>~/.bash_profile_logs/timer_log_file
    (sleep_and_display $1 "$2" "$3" "Time's up!" &)
    exec 1>&3
    exec 3>&-
fi
}

sleep_and_display(){
    sleep $(($1 * 60))
    /usr/bin/osascript <<-EOF
        display dialog "$2" buttons {"$3"} default button "$3" with title "$4"
EOF
}



[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/thch8722/.sdkman"
[[ -s "/Users/thch8722/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/thch8722/.sdkman/bin/sdkman-init.sh"
