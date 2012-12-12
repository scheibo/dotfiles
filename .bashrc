#!/bin/bash

: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}
: ${HOSTFILE=~/.ssh/known_hosts}
: ${INPUTRC=~/.inputrc}

test -r /etc/bashrc && source /etc/bashrc

# Source Facebook definitions
if [ -f /home/engshare/admin/scripts/master.bashrc ]; then
    . /home/engshare/admin/scripts/master.bashrc
fi

set -o notify
set -o emacs
set -o physical
set -o ignoreeof # Ctrl+D doesn't exist

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
ulimit -S -c 0

# allow more open files
ulimit -n 65535

umask 0027   # -rwxr-x---

PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
PATH="/usr/local/bin:$PATH"
test -d "$HOME/bin" &&
PATH="$HOME/bin:$PATH"
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH

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

# ignore backups, CVS directories, python bytecode, vim swap files
FIGNORE="~:CVS:#:.pyc:.swp:.swa:apache-solr-*"
HISTCONTROL=ignoreboth

export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTIGNORE='&:lal:lsl:l:c:clear::cd:..:la:ls:ll:exit:x:[bf]g:history:h:su:make'

HAVE_VIM=$(command -v vim)
HAVE_GVIM=$(command -v gvim)

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

[[ -s "$HOME/.prompt" ]] && source "$HOME/.prompt"

if [ "$UNAME" = Darwin ]; then
    # enable programmable completion features
    if [ -f `brew --prefix`/etc/bash_completion ]; then
      source `brew --prefix`/etc/bash_completion
    fi

    # enable colors on a mac
    export CLICOLOR=1
    export LSCOLORS=ExFxCxDxBxegedabagacad

    export GEMEDITOR=mate

    # put ports on the paths if /opt/local exists
    test -x /opt/local -a ! -L /opt/local && {
        PORTS=/opt/local
        PATH="$PORTS/bin:$PORTS/sbin:$PATH"
        MANPATH="$PORTS/share/man:$MANPATH"
        alias port="sudo nice -n +18 $PORTS/bin/port"
    }

    test -x /usr/pkg -a ! -L /usr/pkg && {
        PATH="/usr/pkg/sbin:/usr/pkg/bin:$PATH"
        MANPATH="/usr/pkg/share/man:$MANPATH"
    }
    test -d /opt/jruby &&
    JRUBY_HOME="/opt/jruby"
    export JRUBY_HOME

    export NODE_PATH=/usr/local/lib/node
else # Linux
  if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
      startx
  fi
fi

[[ -s "$HOME/.shenv" ]] && source "$HOME/.shenv"

puniq () {
    echo "$1" |tr : '\n' |nl |sort -u -k 2,2 |sort -n |
    cut -f 2- |tr '\n' : |sed -e 's/:$//' -e 's/^://'
}

# condense PATH entries
PATH=$(puniq $PATH)
MANPATH=$(puniq $MANPATH)

# set up directory bookmarking (cdable_vars needs to be enabled)
[[ ! -f ~/.dirs ]] && touch ~/.dirs
alias show='cat ~/.dirs'
save (){
    command sed "/!$/d" ~/.dirs > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; echo "$@"=\"`pwd`\" >> ~/.dirs; source ~/.dirs ;
}
source ~/.dirs

[[ -s "$HOME/.aliases" ]] && source "$HOME/.aliases"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export BINPATH=~/Code

[[ -t 0 ]] && stty -ixon

source /home/$USER/.ssh-agent

export CDPATH="$CDPATH:/data/users/kjs"

alias hive_platinum='export HADOOP_HOME=/mnt/vol/hive/sites/platinum/hadoop; export HIVE_HOME=/mnt/vol/hive/sites/platinum/hive; /mnt/vol/hive/sites/platinum/hive/bin/hive'
alias hive='export HADOOP_HOME=/mnt/vol/hive/sites/silver/hadoop; export HIVE_HOME=/mnt/vol/hive/sites/silver/hive; /mnt/vol/hive/sites/silver/hive/bin/hive -i /mnt/vol/hive/dis/lib/udf/hiverc'
alias hive_silver='export HADOOP_HOME=/mnt/vol/hive/sites/silver/hadoop; export HIVE_HOME=/mnt/vol/hive/sites/silver/hive; /mnt/vol/hive/sites/silver/hive/bin/hive'

alias test-ptms="/data/users/kjs/datafreeway/ptail/ptail-metadata/ptail-metadata-service/scripts/test-ptms.sh"
alias test-ranges="/data/users/kjs/datafreeway/ptail/ptail-metadata/ptail-metadata-service/scripts/test-ranges.sh"
alias test-jsonp="/data/users/kjs/datafreeway/ptail/ptail-metadata/ptail-metadata-service/scripts/test-jsonp.sh"
alias loadtest="/data/users/kjs/datafreeway/ptail/ptail-metadata/ptail-metadata-service/scripts/loadtest.rb"

#export http_proxy='http://172.31.255.99:8080'
#export https_proxy="$http_proxy"
#export no_proxy='.facebook.com,.tfbnw.net,fb.com,localhost'

export JAVA_HOME=/usr/local/jdk-7u6-64
export JDK_HOME=$JAVA_HOME
export PATH=$PATH:$JAVA_HOME/bin
export PTAIL_ROOT=/data/users/kjs/datafreeway/ptail

set -o history

