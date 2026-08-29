shopt -s autocd

HISTSIZE=5000

alias ...="cd ../.."
alias back="cd -"


alias update-voltage="~/voltage-theme/bash/update-voltage-theme.sh"

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

# Map .. to go up one directory, optionally into a subdirectory with .. <directory_name>
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

PROMPT_DIRTRIM=2

parse_git_branch() {
  git branch 2>/dev/null | sed -n '/\* /s///p'
}

PS1='\[\e[36m\]\h\[\e[0m\]\[\e[37m\]:\[\e[33m\]$(parse_git_branch)\[\e[37m\]:\[\e[34m\]\w\[\e[0m\]\$ '
