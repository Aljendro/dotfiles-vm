# ~/.bashrc - Bash configuration for VM environment
# Adapted from zshrc for bash

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

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
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth:erasedups

# PATH configuration
export PATH="$DOTFILES_VM_DIR/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# ==============================================================================
# Shell Options
# ==============================================================================

shopt -s histappend   # Append to history file
shopt -s checkwinsize # Update LINES and COLUMNS after each command
shopt -s globstar     # Enable ** glob pattern
shopt -s cdspell      # Autocorrect cd typos
shopt -s dirspell     # Autocorrect directory names
shopt -s autocd       # cd into directory by typing its name

# ==============================================================================
# Vi Mode
# ==============================================================================

set -o vi

# ==============================================================================
# Local Configuration (secrets, machine-specific)
# ==============================================================================

if [[ -f "$HOME/.bashrc_local" ]]; then
  source "$HOME/.bashrc_local"
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

# Source FZF bash integration
eval "$(fzf --bash)"

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
alias t='tmux_switch'
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
alias sb='source ~/.bashrc'
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias grep='grep --color=auto'

# ==============================================================================
# Prompt Configuration
# ==============================================================================

# Git branch in prompt
parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Set prompt colors
RESET='\[\033[0m\]'
BOLD='\[\033[1m\]'
GREEN='\[\033[32m\]'
BLUE='\[\033[34m\]'
CYAN='\[\033[36m\]'
YELLOW='\[\033[33m\]'

# Prompt: user@host:path (git-branch)$
PS1="${GREEN}\u${RESET}@${CYAN}\h${RESET}:${BLUE}\w${YELLOW}\$(parse_git_branch)${RESET}\$ "

# ==============================================================================
# Clipboard Integration (Vi mode yank)
# ==============================================================================

# Copy to clipboard using xclip
copy_to_clipboard() {
  xclip -selection clipboard
}

# ==============================================================================
# Key Bindings (see .inputrc for more)
# ==============================================================================

# Ctrl-L to clear screen (works in vi mode)
bind -x '"\C-l": clear'

# ==============================================================================
# Completion
# ==============================================================================

# Enable programmable completion features
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
  fi
fi

# AWS CLI completion
if command -v aws_completer &>/dev/null; then
  complete -C "$(which aws_completer)" aws
fi

# Git completion
if [[ -f /usr/share/bash-completion/completions/git ]]; then
  source /usr/share/bash-completion/completions/git
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
eval "$(mise activate bash)"
