source ~/.bash_aliases

export GIT_PS1_SHOWDIRTYSTATE=1

RESET="\[\033[0m\]"
WHITE="\[\033[00m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\033[0;33m\]"
PS_TIME="\[\033[\$((COLUMNS-10))G\] $BLUE[\T]"
VENV_BASE="$(basename '${VIRTUAL_ENV}')"

export PS1='$(basename "${VIRTUAL_ENV}")'"${GREEN}\u ${BLUE}\w${YELLOW}"'$(__git_ps1 " (%s)")'" ${GREEN} \n\$${RESET} "
#export PS1="${GREEN} $(__git_ps1)$ "
#export PS1="${GREEN}"'$(__git_ps1)$ '
#PS1="${GREEN}\u ${BLUE}\w${YELLOW}$(__git_ps1) ${GREEN} \n\$${RESET} "
#export PS1='$(basename "${VIRTUAL_ENV}")'${PS1}


#if [[ -n ${VIRTUAL_ENV} ]]; then
  #export PS1="VENV ${PS1}"
#fi


set -o vi

export ROS_IP=$(hostname)
export ROS_HOSTNAME=$(hostname)

eval "$(direnv hook bash)"
. "$HOME/.cargo/env"
