
parse_git_branch() {
  git branch 2>/dev/null | sed -n '/\* /s///p'
}
PS1='\[\e[36m\]\h\[\e[0m\]:\[\e[34m\]\w\[\e[33m\]$(parse_git_branch)\[\e[0m\]\$ '

shopt -s autocd

HISTCONTROL=ignoreboth
shopt -s histappend 
HISTSIZE=5000

alias ...="cd ../.."
alias back="cd -"

alias ebrc="${EDITOR:-vim} ~/.bashrc"
alias sbrc="source ~/.bashrc"

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
