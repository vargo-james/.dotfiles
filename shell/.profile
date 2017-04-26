# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

CDPATH=".:~/projects"

export CPATH='/usr/local/boost_1_60_0'
export LIBRARY_PATH='/usr/local/boost_1_60_0/stage/lib':$LIBRARY_PATH
export LD_LIBRARY_PATH='/usr/local/lib64':$LD_LIBRARY_PATH

#Default editor
EDITOR='/usr/bin/editor'
export EDITOR

#Default browser
BROWSER='/usr/bin/firefox'
export BROWSER

export GDK_USE_XFT=1

#Default home page for lynx
WWW_HOME='http://www.google.com/'
export WWW_HOME

#The next setting disables the beep in the tty, and it does not emit the
#error message in other terminal programs.
if [ -z ${DISPLAY+x} ]; then
  setterm -blength 0
fi

# This command swaps Ctrl with Capslock when in X
if [ -x /usr/bin/setxkbmap ] && [ ! -z ${DISPLAY+x} ]; then
  /usr/bin/setxkbmap -option "ctrl:swapcaps"
fi

