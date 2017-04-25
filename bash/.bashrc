# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt.
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


# Black='\[\033[00;30m\]'
# Red='\[\033[00;31m\]'
# Green='\[\033[00;32m\]'
# Brown='\[\033[00;33m\]'
# Blue='\[\033[00;34m\]'
# Purple='\[\033[00;35m\]'
# Cyan='\[\033[00;36m\]'
# grey='\[\033[00;37m\]'
# 
# Grey='\[\033[01;30m\]'
red='\[\033[01;31m\]'
green='\[\033[01;32m\]'
# Yellow='\[\033[01;33m\]'
# blue='\[\033[01;34m\]'
# purple='\[\033[01;35m\]'
# cyan='\[\033[01;36m\]'
cream='\[\033[01;37m\]'
blank='\[\033[00m\]'
colorized_prompt="${green}\\u@\\h${cream}:${red}\\w${cream}\\$ ${cream}" 
unset red green white blank
plain_prompt="\u@\h:\w\$ "
if [ "$color_prompt" = yes ]; then
  PS1="${debian_chroot:+($debian_chroot)}${colorized_prompt}"
else
  PS1="${debian_chroot:+($debian_chroot)}${plain_prompt}"
fi
unset color_prompt force_color_prompt colorized_prompt plain_prompt

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

mesg y

