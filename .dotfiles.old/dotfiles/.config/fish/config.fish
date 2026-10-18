### Fish 

set fish_greeting

export EDITOR=vim
export VISUAL=vim

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'

alias l="ls -lh"
alias bat="batcat"
alias du="du -h"
alias df="df -h"

alias agi="sudo apt install"
alias agr="sudo apt remove"

alias lazygit="git add . && git commit -m \"$(date)\" && git push"

alias maj="sudo apt-get -y -qq update && sudo apt-get -y -qq full-upgrade && sudo apt-get -y -qq autoremove && sudo aptitude -y -q=5 autoclean && sudo aptitude -y -q=5 purge && sudo aptitude -y -q=5 purge ~c"

export NNN_OPTS='de'
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='o:fzopen;m:mocq;c:fzcd;p:preview-tui'

fzf_configure_bindings --git_status=\ez --git_log=\el --directory=\cf --variables=
 
