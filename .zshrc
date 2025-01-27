# ==============================================================================
# Aliases

# Lua LSP
if [[ ! $(uname) == "Darwin" ]]; then
    alias luamake=$HOME/lua-language-server/3rd/luamake/luamake
fi

# ==============================================================================
# Dotfiles

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# ==============================================================================
# ZSH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

if [[ $(uname) == "Darwin" ]]; then
    plugins=(
        git
        macos
    )
else
    plugins=(git)
fi

source $ZSH/oh-my-zsh.sh

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# ==============================================================================
# Neovim

export EDITOR='nvim'
export KEYTIMEOUT=1

# Use vim keys in tab-complete menu:
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

# ===============================================================================
# FZF

export FZF_DEFAULT_OPTS="
    --reverse
    --multi
    --inline-info
    --height 50% -1
"

# Ripgrep Ignore Glob
RG_IGNORE="'!{.git,node_modules,vendor,dist,build}/*'"

export FZF_DEFAULT_COMMAND="rg --no-require-git --files --hidden -g $RG_IGNORE"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Git Checkout
fgc() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# File search w/ ripgrep and expands argument(s) as path(s)
fra() {
  local files file
  files=$(rg --files $*) &&
  file=$(echo "$files" | fzf +m | sed 's/.*/"&"/')
  [[ "$file" = "" ]] && return || echo "$file" | xargs nvim
}

# ==============================================================================
# Kitty

autoload -Uz compinit && compinit

# Completion
kitty + complete setup zsh | source /dev/stdin

# ==============================================================================
# NVM

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ==============================================================================
# PATH

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.yarn/bin"

# ==============================================================================
# Rust
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"
export PATH="/usr/local/opt/openjdk/bin:$PATH"


# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
