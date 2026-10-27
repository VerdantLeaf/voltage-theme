
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Shell options
shopt -s autocd
shopt -s checkwinsize
shopt -s histappend
shopt -s histverify
shopt -s cdspell
shopt -s dirspell
shopt -s globstar

# History
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT='%F %T '

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Navigation
alias ...="cd ../.."
alias ....="cd ../../.."
alias bk="cd -"


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias l='ls -CF --color=auto'
    alias lt='ls -lahtr --color=auto'
    alias ls="ls --color=auto"
    alias ll="ls -alF -h --color=auto"
    alias la="ls -A --color=auto"
    alias grep='grep --color=auto'
fi

# git
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias gpl="git pull"

alias df="df -h"
alias du="du -h"
alias free="free -h"

VOLTAGE_RAW="https://raw.githubusercontent.com/VerdantLeaf/voltage-theme/main/bash"
update-bash() { curl -fsSL "$VOLTAGE_RAW/update-bash.sh" | bash; }
update-voltage() { curl -fsSL "$VOLTAGE_RAW/update-voltage.sh" | bash; }
alias less="less -R -N"
alias python="python3"

PROMPT_DIRTRIM=2

# Funcs
parse_git_branch() {
  git branch --show-current 2>/dev/null
}

PS1='\[\e[36m\]\h\[\e[0m\]\[\e[37m\]:\[\e[33m\]$(parse_git_branch)\[\e[37m\]:\[\e[34m\]\w\[\e[0m\]\$ '
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

mkcd() { mkdir -p -- "$1" && cd -- "$1"; }




nano() {

  local default_flags="-l -E -i -S -m"

  if [ -n "$DISPLAY" ] && command -v gnome-terminal >/dev/null 2>&1; then
    gnome-terminal --tab -- \nano $default_flags "$@"
  else 
    \nano $default_flags "$@"
  fi
}