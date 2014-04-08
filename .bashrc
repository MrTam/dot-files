# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
 
# If not running interactively, don't do anything
[ -z "$PS1" ] && return
 
# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace
 
# append to the history file, don't overwrite it
shopt -s histappend
 
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
 
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
 
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
 
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
 
# set a fancy prompt (non-color, unless we know we "want" color)
if [ $COLORTERM == "gnome-terminal" ]; then
    TERM=xterm-256color
fi

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
 
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi
 
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
 
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|screen*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
 
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
 
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
 
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
 
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
 
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
 
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
 
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

function todos
{
    for file in $@; do
        todos=(`cat $file | grep -n TODO | sed 's/TODO: //g'`);

        if [ ${#todos[@]} -gt 0 ]; then
            echo $file:
            for todo in $todos; do
                echo $todo
            done
        fi
    done
}

function ext_rename
{
    if [ $# -ne 2 ]; then
        echo "usage: ext_rename <from> <to>"
    else
        export SOURCE=$1
        export DEST=$2
        find *.$SOURCE -exec bash -c 'mv {} `echo {} | cut -d "." -f1`.$DEST' \; 
    fi
}

function forge
{
    FILE=${1:-$(basename `pwd`).vsl}

    if [ -e $FILE ]; then
        BINARY="java -jar $FORGE_PATH/target/forge-0.0.1-SNAPSHOT.jar"
        INPUT=$(readlink -m -n $FILE)
        OUTPUT=${2:-`pwd`/$(basename ${INPUT%.*})}.xml
        CMD="$BINARY -x=$FORGE_PATH/resources/product-definition-fh.xsd -p=/home/tgibson/vulcan/vsl/packages -v=$INPUT -o=$OUTPUT -c=false"
        $CMD
    else
        echo "error: $FILE does not exist" > /dev/stderr
        return 1
    fi
}

export CC=clang
export CXX=clang++

export PATH=/opt/openmama/bin:/home/tgibson/llvm/llvm/tools/clang/tools/scan-build:/home/tgibson/llvm/llvm/tools/clang/tools/scan-view:$PATH
export LD_LIBRARY_PATH=/opt/openmama/lib:/opt/vulcan/lib:/usr/local/lib:$LD_LIBRARY_PATH
export WOMBAT_PATH=/opt/openmama/config/

export LOCAL_CLIENT_KEY=hFBP5FP2Q237MGnvrW3w9h8uUljVMmX4r8tc0gMZ
export LOCAL_CLIENT_SECRET=UbQnok2awIDxwYFruCyLODhFfM2uCyRXKCiWz1QnJxKZsg1nFnvJ5GZ
export CLASSPATH=/usr/local/lib/antlr-4.1-complete.jar:$CLASSPATH
export FORGE_PATH=/home/tgibson/vulcan/forge/

export LANG=en_GB.UTF-8
export LOCALE=UTF-8

alias catalyst='python -m catalyst.main'
alias scons='scons -j4'
alias helgrind='valgrind --tool=helgrind'
alias callgrind='valgrind --tool=callgrind'
alias cachegrind='valgrind --tool=cachegrind'

alias anvil='anvil -s localhost -k $LOCAL_CLIENT_KEY -t $LOCAL_CLIENT_SECRET'
