# ~/.zshrc - Zsh configuration for VM environment

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ==============================================================================
# Environment Variables
# ==============================================================================

export DOTFILES_VM_DIR="$HOME/dotfiles-vm"
export RIPGREP_CONFIG_PATH="$HOME/.ripgrep"
export EDITOR="nvim"
export VISUAL="nvim"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export HISTSIZE=10000
export SAVEHIST=20000
export HISTFILE="$HOME/.zsh_history"

# PATH configuration
export PATH="$DOTFILES_VM_DIR/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# ==============================================================================
# Shell Options
# ==============================================================================

setopt APPEND_HISTORY        # Append to history file
setopt HIST_IGNORE_DUPS      # Ignore duplicate commands
setopt HIST_IGNORE_ALL_DUPS  # Remove older duplicate entries
setopt HIST_IGNORE_SPACE     # Ignore commands starting with space
setopt EXTENDED_GLOB         # Enable extended glob patterns
setopt AUTO_CD               # cd into directory by typing its name
setopt CORRECT               # Autocorrect typos

# ==============================================================================
# Vi Mode
# ==============================================================================

bindkey -v

# Reduce key timeout for mode switching
export KEYTIMEOUT=1

# Change cursor shape for different vi modes
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select

# Use beam cursor on startup and for each new prompt
zle-line-init() { echo -ne '\e[6 q' }
zle -N zle-line-init

# ==============================================================================
# Local Configuration (secrets, machine-specific)
# ==============================================================================

if [[ -f "$HOME/.zshrc_local" ]]; then
  source "$HOME/.zshrc_local"
fi

# ==============================================================================
# FZF Configuration
# ==============================================================================

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border
  --preview-window=right:60%:wrap
  --bind=ctrl-u:preview-half-page-up
  --bind=ctrl-d:preview-half-page-down
  --bind=ctrl-f:preview-page-down
  --bind=ctrl-b:preview-page-up
  --bind=ctrl-/:toggle-preview
'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# Source FZF zsh integration
eval "$(fzf --zsh)"

# ==============================================================================
# Aliases
# ==============================================================================

alias e='exit'

# Editor shortcuts
alias n='nvim'
alias nn='nvim -u NONE'
alias nf='nvim $(fzf)'
alias ng='nvim $(rg --files-with-matches "" | fzf --preview "rg --color=always -n {} 2>/dev/null | head -200")'

# Tmux
alias ta='tmux attach -t'
alias tn='tmux new-session -s'
alias tl='tmux list-sessions'

# Git
alias g='git'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -20'
alias gco='git checkout'
alias gb='git branch'
alias gw='git worktree'
alias ginit='git init && git add . && git commit -am "init"'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# List files
alias l='ls -lah --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -lAh --color=auto'
alias ls='ls --color=auto'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Utilities
alias sz='source ~/.zshrc'
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias grep='grep --color=auto'

# ==============================================================================
# Prompt Configuration
# ==============================================================================

# Enable prompt substitution
setopt PROMPT_SUBST

# Git branch in prompt
parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Prompt: user@host:path (git-branch)$
PROMPT='%F{green}%n%f@%F{cyan}%m%f:%F{blue}%~%F{yellow}$(parse_git_branch)%f$ '

# ==============================================================================
# Clipboard Integration (Vi mode yank)
# ==============================================================================

# Copy to clipboard using xclip
copy_to_clipboard() {
  xclip -selection clipboard
}

# ==============================================================================
# Key Bindings
# ==============================================================================

# Ctrl-L to clear screen (works in vi mode)
bindkey -M viins '^L' clear-screen
bindkey -M vicmd '^L' clear-screen

# Ctrl-A and Ctrl-E for line navigation (emacs-style convenience)
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line

# Ctrl-W to delete word backward
bindkey -M viins '^W' backward-kill-word

# Ctrl-U to delete line backward
bindkey -M viins '^U' kill-whole-line

# Ctrl-K to delete to end of line
bindkey -M viins '^K' kill-line

# Ctrl-P and Ctrl-N for history
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^N' down-line-or-history
bindkey -M vicmd '^P' up-line-or-history
bindkey -M vicmd '^N' down-line-or-history

# k and j in command mode for history search
bindkey -M vicmd 'k' history-search-backward
bindkey -M vicmd 'j' history-search-forward

# Arrow keys for history search based on current input
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# v in command mode to edit in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

# ==============================================================================
# Completion
# ==============================================================================

# Initialize completion system
autoload -Uz compinit && compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Colored completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Menu selection
zstyle ':completion:*' menu select

# AWS CLI completion
if command -v aws_completer &>/dev/null; then
  autoload bashcompinit && bashcompinit
  complete -C "$(which aws_completer)" aws
fi

# ==============================================================================
# Final Setup
# ==============================================================================

# Greeting (optional, remove if unwanted)
if [[ -z "$TMUX" ]]; then
  echo "Welcome to $(hostname) - $(date '+%Y-%m-%d %H:%M')"
fi
# Lima BEGIN
# Make sure iptables and mount.fuse3 are available
PATH="$PATH:/usr/sbin:/sbin"
export PATH
# Lima END

# Activate MISE Globals
eval "$(mise activate zsh)"
