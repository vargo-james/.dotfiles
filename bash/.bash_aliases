# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Make an alias for the g++ compiler
alias g++='g++ -std=c++14 -g -Wall -I/usr/local/boost_1_60_0'

alias vimall='vim **/*.[hc]*'

alias makefast='make -j --warn-undefined-variables'

# This command gives the current percentage of battery power.
alias battery="upower -i $(upower -e | grep 'BAT') | sed -rn 's/.*percentage[^0-9]*([0-9]*%).*/\1/p'"

alias lpr='lp'

alias volume='amixer set Master'
alias mute='amixer set Master mute &> /dev/null'
alias unmute='amixer set Master unmute &> /dev/null'
alias vup='amixer set Master 10%+ &> /dev/null'
alias vdown='amixer set Master 10%- &> /dev/null'
alias vmax='amixer set Master 100% unmute &> /dev/null'


