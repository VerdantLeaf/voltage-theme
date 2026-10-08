
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

shopt -s autocd
shopt -s checkwinsize

HISTSIZE=5000

alias ...="cd ../.."
alias back="cd -"


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls="ls --color=auto"
    alias ll="ls -alF -h --color=auto"
    alias la="ls -A --color=auto"
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"

alias df="df -h"
alias du="du -h"
alias free="free -h"

alias ...="cd ../.."
alias back="cd -"

alias update-voltage="~/voltage-theme/bash/update-voltage-theme.sh"
alias less="less -R -N"

alias less="less -R -N"
alias nano="nano -l -E -i -S -m -B"

alias python="python3"

# Get sizes of dirs and files using du, but map to lz and make it colorful
lz() {
    du -ahd 1 "${@:-.}" | sort -h | while IFS=$'\t' read -r size path; do
        if [ -d "$path" ]; then
            printf '%s\t\e[1;34m%s\e[0m\n' "$size" "$path"
        else
            printf '%s\t%s\n' "$size" "$path"
        fi
    done
}

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
