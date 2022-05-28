source $HOME/.aliases

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="hyperzsh"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ============================================================== /
# Vim mode

export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Text navigation
bindkey -M vicmd 'L' vi-end-of-line
bindkey -M vicmd 'H' vi-beginning-of-line

# Change cursor shape for different vim modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vim insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
precmd() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Text Motions - Change ( ci", ci', ci`, di", etc )
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# Brace and Brackets Motions  ( ci{, ci(, ci<, di{, etc )
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

# Initiate Key Remaps (e.g, Caps as Esc)
# only for X server
# xmodmap ~/.Xmodmap

# ============================================================== /
# FZF

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS="
    --reverse
    --multi
    --inline-info
    --height 50% -1
"
# Use c-n / c-p instead of this
# --bind alt-j:down,alt-k:up

# Ripgrep for FZF
RG_IGNORE="'!{.git,node_modules,vendor,dist,build}/*'"
# RG_IGNORE="'!{.git,node_modules,**/node_modules,vendor,dist,**/dist,build}/*'"

export FZF_DEFAULT_COMMAND="rg --no-require-git --files --hidden -g $RG_IGNORE"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# FZF Git Checkout
fgc() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# FZF file search via ripgrep and expands argument(s) as path(s)
fra() {
  local files file
  files=$(rg --files $*) &&
  file=$(echo "$files" | fzf +m | sed 's/.*/"&"/')
  [[ "$file" = "" ]] && return || echo "$file" | xargs nvim
}

# ============================================================== /
# Kitty

autoload -Uz compinit
compinit

# Completion
kitty + complete setup zsh | source /dev/stdin

# ============================================================== /
# Alacritty

fpath+=${ZDOTDIR:-~}/.zsh_functions

# ============================================================== /
# $PATH variables

# export QT_QPA_PLATFORM=xcb

# Source NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Add RVM to path for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

# Nvim
# export PATH="$PATH:$HOME/neovim/bin"

# QMK
export PATH="$PATH:$HOME/.local/bin"

# Yarn
export PATH="$PATH:$HOME/.yarn/bin"
