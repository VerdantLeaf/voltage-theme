

shopt -s autocd
shopt -s histappend

HISTCONTROL=ignoreboth 
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
alias lz="du -ahd 1 | sort -h" # Get the true size of everything in a dir 
alias grep="grep --color=auto"
alias df="df -h"
alias du="du -h"
alias free="free -h"

alias less="less -R -N" # colors and line numbers
alias python="python3"

# map .. --> cd .. 
# but also allow .. hdl to map to cd ../hdl
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

# Prompt shows [device]:[git branch (if relevant)]:[last two dir levels]
PROMPT_DIRTRIM=2
parse_git_branch() {
  git branch 2>/dev/null | sed -n '/\* /s///p'
}
PS1='\[\e[36m\]\h\[\e[0m\]:\[\e[33m\]$(parse_git_branch)\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]\$ '

