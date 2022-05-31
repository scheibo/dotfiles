#!/bin/bash
export BASH_SILENCE_DEPRECATION_WARNING=1 # fuck you Apple

: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}
: ${HOSTFILE=~/.ssh/known_hosts}
: ${INPUTRC=~/.inputrc}

test -r /etc/bashrc && source /etc/bashrc

set -o notify
set -o emacs
set -o physical
set -o ignoreeof # turn off Ctrl+D

# http://ss64.com/bash/shopt.html
shopt -s cdable_vars >/dev/null 2>&1
shopt -s cdspell >/dev/null 2>&1
shopt -s checkhash >/dev/null 2>&1
shopt -s checkwinsize >/dev/null 2>&1
shopt -s cmdhist >/dev/null 2>&1
shopt -s dotglob >/dev/null 2>&1
shopt -s extglob >/dev/null 2>&1
shopt -s expand_aliases >/dev/null 2>&1
shopt -s histappend >/dev/null 2>&1
shopt -s histreedit >/dev/null 2>&1
shopt -s hostcomplete >/dev/null 2>&1
shopt -s interactive_comments >/dev/null 2>&1
shopt -s no_empty_cmd_completion >/dev/null 2>&1
shopt -s progcomp >/dev/null 2>&1
shopt -s promptvars >/dev/null 2>&1

# bash 4 features
if [[ ${BASH_VERSINFO[0]} -ge 4 ]]; then
  shopt -s globstar
  shopt -s autocd
fi

shopt -u mailwarn >/dev/null 2>&1
unset MAILCHECK

# disable core dumps
#ulimit -S -c 0

# allow more open files
#ulimit -n 32768

# -rwxr-x---
umask 0027

case "$-" in
    *i*) INTERACTIVE=yes ;;
    *)   unset INTERACTIVE ;;
esac

case "$0" in
    -*) LOGIN=yes ;;
    *)  unset LOGIN ;;
esac

: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

: ${FTP_PASSIVE:=1}
export FTP_PASSIVE

FIGNORE="~:CVS:#:.pyc:.swp:.swa:apache-solr-*"
HISTCONTROL=ignoreboth

export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTIGNORE='&:lal:lsl:l:c:clear::cd:..:la:ls:ll:exit:x:[bf]g:history:h:su'

HAVE_VIM=$(command -v vim)

test -n "$HAVE_VIM" &&
EDITOR=vim ||
EDITOR=vi
export EDITOR

if test -n "$(command -v less)" ; then
    PAGER="less -FirSwX"
    MANPAGER="less -FiRswX"
else
    PAGER=more
    MANPAGER="$PAGER"
fi
export PAGER MANPAGER
ACK_PAGER="$PAGER"

# set up directory bookmarking (cdable_vars needs to be enabled)
[[ ! -f ~/.dirs ]] && touch ~/.dirs
alias show='cat ~/.dirs'
save (){
    command sed "/!$/d" ~/.dirs > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; echo "$@"=\"`pwd`\" >> ~/.dirs; source ~/.dirs ;
}
source ~/.dirs

PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin:$HOME/Code/bin"
PATH="/usr/local/go/bin:/usr/local/bin:$PATH"

[[ -s "$HOME/.prompt" ]] && source "$HOME/.prompt"
[[ -s "$HOME/.shenv" ]] && source "$HOME/.shenv"
[[ -s "$HOME/.aliases" ]] && source "$HOME/.aliases"
[[ -s "$HOME/.git-aliases" ]] && source "$HOME/.git-aliases"

puniq () {
    echo "$1" |tr : '\n' |nl |sort -u -k 2,2 |sort -n |
    cut -f 2- |tr '\n' : |sed -e 's/:$//' -e 's/^://'
}

# condense PATH entries
export PATH=$(puniq $PATH)
export MANPATH=$(puniq $MANPATH)

if [ "$UNAME" = Darwin ]; then
    export PATH="/opt/homebrew/bin:$PATH"
    # enable programmable completion features
    if [ -f `brew --prefix`/etc/bash_completion ]; then
      source `brew --prefix`/etc/bash_completion
    fi

    # enable colors on a mac
    export CLICOLOR=1
    export LSCOLORS=ExFxCxDxBxegedabagacad

    # /usr/libexec/java_home -v 1.7
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_76.jdk/Contents/Home"
fi #else # Linux
  #if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
      #startx
  #fi
#fi

[[ -s "$HOME/.fzf.bash" ]] && source "$HOME/.fzf.bash"

[[ -t 0 ]] && stty -ixon

set -o history
