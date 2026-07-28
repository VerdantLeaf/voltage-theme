

shopt -s autocd

HISTSIZE=5000

alias ...="cd ../.."
alias back="cd -"


alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"

alias ls="ls --color=auto -f"
alias ll="ls -alF -h"
alias la="ls -A"
alias lz="du -ahd 1 | sort -h"
alias grep="grep --color=auto"
alias df="df -h"
alias du="du -h"
alias free="free -h"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

alias less="less -R -N"

alias python="python3"

..() {
  if [ -z "$1" ]; then
    cd ..
  else 
    cd "../$1"
  fi
}

_parent_dir_complete() {
  local IFS=$'\n'
  COMPREPLY=( $(cd .. && compgen -d -- "$2") )
}

complete -F _parent_dir_complete ..
