#!/bin/bash

# the basics
: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

# complete hostnames from this file
: ${HOSTFILE=~/.ssh/known_hosts}

# readline config
: ${INPUTRC=~/.inputrc}

# ----------------------------------------------------------------------
#  SHELL OPTIONS
# ----------------------------------------------------------------------

# bring in system bashrc
test -r /etc/bashrc &&
      . /etc/bashrc

# notify of bg job completion immediately
set -o notify

set -o emacs
# set -o noclobber
set -o physical
set -o ignoreeof # prevent accidental Ctrl+D

# shell opts. see bash(1) for details
shopt -s cdspell >/dev/null 2>&1
shopt -s extglob >/dev/null 2>&1
shopt -s histappend >/dev/null 2>&1
shopt -s hostcomplete >/dev/null 2>&1
shopt -s interactive_comments >/dev/null 2>&1
shopt -s no_empty_cmd_completion >/dev/null 2>&1

shopt -s dotglob >/dev/null 2>&1
shopt -s cmdhist >/dev/null 2>&1
shopt -s lithist >/dev/null 2>&1
shopt -s progcomp >/dev/null 2>&1
shopt -s checkhash >/dev/null 2>&1
shopt -s histreedit >/dev/null 2>&1
shopt -s promptvars >/dev/null 2>&1
shopt -s cdable_vars >/dev/null 2>&1
shopt -s checkwinsize >/dev/null 2>&1
shopt -s hostcomplete >/dev/null 2>&1
shopt -s expand_aliases >/dev/null 2>&1
shopt -s histappend >/dev/null 2>&1

# fuck that you have new mail shit
shopt -u mailwarn >/dev/null 2>&1
unset MAILCHECK

# disable core dumps
ulimit -S -c 0

# default umask
umask 0027 # -rwxr-x---
# umask 0077 # -rw------

# ----------------------------------------------------------------------
# PATH
# ----------------------------------------------------------------------

# we want the various sbins on the path along with /usr/local/bin
PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
PATH="/usr/local/bin:$PATH"

# put ~/bin on PATH if you have it
test -d "$HOME/bin" &&
PATH="$HOME/bin:$PATH"

export CDPATH=.:~:~/Code/src:~/Code/src/work:~/Documents/school:~/Documents/school/cs246:~/Code/src/www:~/Code
export PATH=$PATH:/usr/local/bin:~/bin:~/src/python:~/src/:/usr/share/java/apache-ant/bin:/usr/local/mysql/bin:~/Code/bin:~/.cabal/bin:/usr/local/share/npm/bin

# ----------------------------------------------------------------------
# ENVIRONMENT CONFIGURATION
# ----------------------------------------------------------------------

# detect interactive shell
case "$-" in
    *i*) INTERACTIVE=yes ;;
    *)   unset INTERACTIVE ;;
esac

# detect login shell
case "$0" in
    -*) LOGIN=yes ;;
    *)  unset LOGIN ;;
esac

# enable en_US locale w/ utf-8 encodings if not already configured
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# always use PASSIVE mode ftp
: ${FTP_PASSIVE:=1}
export FTP_PASSIVE

# ignore backups, CVS directories, python bytecode, vim swap files
FIGNORE="~:CVS:#:.pyc:.swp:.swa:apache-solr-*"
HISTCONTROL=ignoreboth

export HISTFILESIZE=1000
export HISTSIZE=1000
export HISTIGNORE='&:lal:lsl:l:c:clear::cd:..:la:ls:ll:exit:x:[bf]g:history:h:su:make'

# ----------------------------------------------------------------------
# PAGER / EDITOR
# ----------------------------------------------------------------------

# See what we have to work with ...
HAVE_VIM=$(command -v vim)
HAVE_GVIM=$(command -v gvim)

# EDITOR
test -n "$HAVE_VIM" &&
EDITOR=vim ||
EDITOR=vi
export EDITOR

# PAGER
if test -n "$(command -v less)" ; then
    PAGER="less -FirSwX"
    MANPAGER="less -FiRswX"
else
    PAGER=more
    MANPAGER="$PAGER"
fi
export PAGER MANPAGER

# Ack
ACK_PAGER="$PAGER"

# ----------------------------------------------------------------------
# PROMPT
# ----------------------------------------------------------------------


# RED="\[\033[0;31m\]"
# BROWN="\[\033[0;33m\]"
# GREY="\[\033[0;97m\]"
# BLUE="\[\033[0;34m\]"
# PS_CLEAR="\[\033[0m\]"
# SCREEN_ESC="\[\033k\033\134\]"
#
# if [ "$LOGNAME" = "root" ]; then
#     COLOR1="${RED}"
#     COLOR2="${BROWN}"
#     P="#"
# elif hostname | grep -q 'github\.com'; then
#     GITHUB=yep
#     COLOR1="\[\e[0;94m\]"
#     COLOR2="\[\e[0;92m\]"
#     P="\$"
# else
#     COLOR1="${BLUE}"
#     COLOR2="${BROWN}"
#     P="\$"
# fi
#
# prompt_simple() {
#     unset PROMPT_COMMAND
#     PS1="[\u@\h:\w]\$ "
#     PS2="> "
# }
#
# prompt_compact() {
#     unset PROMPT_COMMAND
#     PS1="${COLOR1}${P}${PS_CLEAR} "
#     PS2="> "
# }
#
# prompt_color() {
#     PS1="${GREY}[${COLOR1}\u${GREY}@${COLOR2}\h${GREY}:${COLOR1}\W${GREY}]${COLOR2}$P${PS_CLEAR} "
#     PS2="\[[33;1m\]continue \[[0m[1m\]> "
# }

PS1="\[\e[32;1m\]\`if [[ \$? = "0" ]]; then echo "\\[\\e[32m\\]"; else echo "\\[\\e[31m\\]"; fi\`\u@\h$\[\e[37;0m\] "

# ----------------------------------------------------------------------
# MACOS X / DARWIN SPECIFIC
# ----------------------------------------------------------------------

if [ "$UNAME" = Darwin ]; then

    # enable programmable completion features
    if [ -f `brew --prefix`/etc/bash_completion ]; then
      . `brew --prefix`/etc/bash_completion
    fi

    # enable colors on a mac
    export CLICOLOR=1
    export LSCOLORS=ExFxCxDxBxegedabagacad

    source .hg_bash_completion
    export GEMEDITOR=mate

    # put ports on the paths if /opt/local exists
    test -x /opt/local -a ! -L /opt/local && {
        PORTS=/opt/local

        # setup the PATH and MANPATH
        PATH="$PORTS/bin:$PORTS/sbin:$PATH"
        MANPATH="$PORTS/share/man:$MANPATH"

        # nice little port alias
        alias port="sudo nice -n +18 $PORTS/bin/port"
    }

    test -x /usr/pkg -a ! -L /usr/pkg && {
        PATH="/usr/pkg/sbin:/usr/pkg/bin:$PATH"
        MANPATH="/usr/pkg/share/man:$MANPATH"
    }

    # setup java environment. puke.
    JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
    ANT_HOME="/Developer/Java/Ant"
    export ANT_HOME JAVA_HOME

    # hold jruby's hand
    test -d /opt/jruby &&
    JRUBY_HOME="/opt/jruby"
    export JRUBY_HOME

    export NODE_PATH=/usr/local/lib/node
fi

# -------------------------------------------------------------------
# USER SHELL ENVIRONMENT
# -------------------------------------------------------------------

# source ~/.shenv now if it exists
test -r ~/.shenv &&
. ~/.shenv

puniq () {
    echo "$1" |tr : '\n' |nl |sort -u -k 2,2 |sort -n |
    cut -f 2- |tr '\n' : |sed -e 's/:$//' -e 's/^://'
}

# condense PATH entries
PATH=$(puniq $PATH)
MANPATH=$(puniq $MANPATH)

# Use the color prompt by default when interactive
# test -n "$PS1" &&
# prompt_color

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

set -o history
