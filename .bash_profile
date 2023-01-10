source ~/.bash_aliases

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[01;32m\]\u\[\033[01;34m\] \w\[\033[00;33m\]$(__git_ps1)\[\033[01;32m\] \n\$\[\033[00m\] '

RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\033[0;33m\]"
PS_TIME="\[\033[\$((COLUMNS-10))G\] $BLUE[\T]"
#export PS1="\[\033[01;32m\]\u\[\033[01;34m\] \w\[\033[00;33m\]$(__git_ps1)\[\033[01;32m\]${PS_TIME}\n${RESET}\$ "

set -o vi

export ROS_IP=$(hostname)
export ROS_HOSTNAME=$(hostname)

. "$HOME/.cargo/env"
