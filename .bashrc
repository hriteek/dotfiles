# # Kiro CLI pre block. Keep at the top of this file.
# [[ -f "${HOME}/.local/share/kiro-cli/shell/bashrc.pre.bash" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/bashrc.pre.bash"

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Activate vi mode with <Escape>:
# set -o vi
# set show-mode-in-prompt on
# bind '"jk":vi-movement-mode'
# # Enable showing the mode
# bind 'set show-mode-in-prompt on'
# # Command (normal) mode → steady block
# bind 'set vi-cmd-mode-string \1\e[2 q\2'
# # Insert mode → steady bar
# bind 'set vi-ins-mode-string \1\e[6 q\2'
export EDITOR=nvim

# If not running interactively, don't do anything
# case $- in
# *i*) ;;
# *) return ;;
# esac

# if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
# 	exec tmux
# fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
# to enable ctrl+s to search forward in reverse-i-search
# stty -ixon
if [ -t 0 ]; then
  stty -ixon 2>/dev/null
fi

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=
export HISTFILESIZE=

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi

# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF --color=always --group-directories-first'
alias la='ls -A --color=always --group-directories-first'
alias ls='ls --color=always --group-directories-first'
alias l='ls -CF --color=always --group-directories-first'
alias rm='trash -v'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# import alisa from .alises file
# . ~/.aliases
alias g='git'
alias gi='git init && git add -A && git commit -m "feat(*): initial commit"'
alias ga='git add -A'
alias gs='git status'
alias gfa='git fetch'
alias gf='git pullo'
alias gp='git push'
alias gpu='git pushup'
alias gpm='git pull origin master'
alias gab='git branch'
alias gb='git branch --show-current'
alias gr='git remote --v'
alias gsm='git switch master'
alias gc='git switch -'
alias gl='git lg'
alias grh='git reset --hard'
alias gcb='git switch -c'

# alias ze='zellij'
# bind -x '"\C-z": "zellij"'

# source bashrc
alias srcbash='source ~/.bashrc'

alias cat='bat'
alias ll='eza -l --icons'
alias ls='eza --icons'
alias la='eza --icons -a'
alias c='xclip -selection clipboard'
alias copy='xclip -selection clipboard <'
# alias v='xclip -o'

ls="ls -hN --color=auto --group-directories-first"
grep="grep --color=auto"

alias co="code"
alias coo="code ."
alias cor="code -r ."
alias coa="code -a ."

alias ci="code-insiders"
alias cio="code-insiders ."
alias cir="code-insiders -r ."
alias cia="code-insiders -a ."

alias su="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && command -v brew >/dev/null 2>&1 && brew update && brew upgrade"
alias sr="snap refresh"
alias vim="nvim"
alias e="exit"
alias cl="clear"

# kubectl
kc() {
  if [ "$#" -eq 0 ]; then
    # No argument provided, list contexts
    kubectl config get-contexts
  else
    # Argument provided, set context
    kubectl config use-context "$1"
  fi
}
alias k="kubectl"

# function as alias
mc() { # create dir and move inside dir
  mkdir "$1" && cd "$1"
}

# fzf
export FZF_DEFAULT_OPTS='--height 40% --no-reverse --multi'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# source /usr/share/doc/fzf/examples/key-bindings.bash

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# alisa for the dotfile config
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

export PATH="$HOME/.local/bin:$PATH"

# Only run in interactive shells
[[ $- != *i* ]] && return

# Skip dumb terminals
[[ "$TERM" == "dumb" ]] && return

# starship.rs
eval "$(starship init bash)"

# # bun.sh
# BUN_INSTALL="/home/hriteek/.bun"
# PATH="$BUN_INSTALL/bin:$PATH"
# . "$HOME/.cargo/env"

# android
DEV_TOOLS="$HOME/Applications"
# JAVA_HOME="$DEV_TOOLS/JDK/jdk-11.0.7+10"
ANDROID_HOME="$DEV_TOOLS/android"
export JAVA_HOME
export ANDROID_HOME
# PATH="$JAVA_HOME/bin:$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/platform-tools:$PATH"
PATH="$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

# export ANDROID_HOME=$HOME/Applications/android/Sdk
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/tools/bin

# flutter
export PATH=$PATH:$HOME/Applications/flutter/bin

# https://github.com/commitizen/cz-cli#making-your-repo-commitizen-friendly
alias czi="commitizen init cz-conventional-changelog --save-dev --save-exact"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init bash)"
export _ZO_ECHO='1'
alias zz="z -"
# alias cd="z"

# lf icons
export LF_ICONS="\
tw=:\
st=:\
ow=:\
dt=:\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
"

PATH=~/.console-ninja/.bin:$PATH
[ -f "/home/hriteek/.ghcup/env" ] && source "/home/hriteek/.ghcup/env" # ghcup-env
PATH=$PATH:/usr/local/go/bin
# set PATH so it includes GOPATH/bin if it exists
if [ -x "$(command -v go)" ] && [ -d "$(go env GOPATH)/bin" ]; then
  PATH="$(go env GOPATH)/bin:$PATH"
fi

# yazi
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# fnm
FNM_PATH="/home/hriteek/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env)"
fi
# eval "$(fnm env --use-on-cd)"
# eval "$(fnm env --use-on-cd --shell bash)"
# eval "$(fnm env)"

# # start tmux on every shell login
# if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
#   tmux attach || tmux >/dev/null 2>&1
# fi
alias python=python3
export PATH="/mnt/c/Users/User/AppData/Local/Programs/Microsoft VS Code/bin":$PATH

# encore
export ENCORE_INSTALL="/home/hriteek/.encore"
export PATH="$ENCORE_INSTALL/bin:$PATH"

[[ -s "/home/hriteek/.gvm/scripts/gvm" ]] && source "/home/hriteek/.gvm/scripts/gvm"

# Add VS Code and Code Insiders to PATH
export PATH="$PATH:/mnt/c/Users/User/AppData/Local/Programs/Microsoft VS Code/bin"
export PATH="$PATH:/mnt/c/Users/User/AppData/Local/Programs/Microsoft VS Code Insiders/bin"
export PATH="/home/linuxbrew/.linuxbrew/lib/ruby/gems/3.4.0/bin:$PATH"

# opencode
export PATH=/home/hriteek/.opencode/bin:$PATH

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Kiro CLI post block. Keep at the bottom of this file.
# [[ -f "${HOME}/.local/share/kiro-cli/shell/bashrc.post.bash" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/bashrc.post.bash"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init bash)"; fi

export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
