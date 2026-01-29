# dotfiles-vm

Lightweight dotfiles for Fedora VM environments (Lima, etc.).

## Prerequisites

- **Ansible** - Version 2.10 or higher
- **Python 3** - Required by Ansible

The Ansible playbook will automatically install all other required tools:

- **stow** - Symlink farm manager
- **git** - Version control
- **nvim** - Neovim editor
- **tmux** - Terminal multiplexer
- **fzf** - Fuzzy finder
- **fd** - Fast file finder
- **ripgrep** - Fast grep
- **bat** - Cat with syntax highlighting
- **delta** - Git diff viewer
- **xclip** - Clipboard support

## Installation

### Quick Install (Fedora)

```bash
# Clone the repository
git clone https://github.com/Aljendro/dotfiles-vm.git
cd ~/dotfiles-vm

# Install Ansible and required collections
sudo dnf install -y ansible
ansible-galaxy collection install -r requirements.yml

# Run the playbook
ansible-playbook install.yml
```

## What's Included

### Bash Configuration (`stow/bash/`)

- `.bashrc` - Main shell configuration with:
  - Vi mode editing
  - FZF integration
  - NVM lazy loading
  - Git-aware prompt
  - Useful aliases
- `.bash_profile` - Login shell setup
- `.inputrc` - Readline configuration for vi mode
- `.bashrc_local` - Template for local/secret variables

### Git Configuration (`stow/git/`)

- `.gitconfig` - Git settings with:
  - Delta pager for diffs
  - Useful aliases
- `.gitignore_global` - Global gitignore patterns

### Tmux Configuration (`stow/tmux/`)

- `.tmux.conf` - Tmux settings with:
  - Prefix remapped to Ctrl+A
  - Vi keybindings

### Neovim Configuration (`stow/nvim/`)

- `.config/nvim/` - Neovim starter config (submodule)

### Other Tools

- `stow/ripgrep/.ripgrep` - Ripgrep defaults
- `stow/fzf/.fzf.bash` - FZF bash integration
- `stow/bin` - Utility scripts

## Key Bindings

### Bash (Vi Mode)

- `Esc` or `jk` - Enter command mode
- `k/j` - History search (command mode)
- `Ctrl+R` - FZF reverse history search
- `Ctrl+T` - FZF file finder
- `Alt+C` - FZF directory changer

### Tmux

- `Ctrl+A` - Prefix
- `Prefix + f` - Enter copy mode
- `Prefix + t` - Fuzzy session switcher
- `Prefix + h/j/k/l` - Pane navigation
- `Prefix + v/s` - Split panes
- `Prefix + n/N` - New window

## Customization

Edit `~/.bashrc_local` for machine-specific settings:

```bash
# AWS Configuration
export AWS_PROFILE="default"

# API Keys
export ANTHROPIC_API_KEY="sk-..."

# Custom aliases
alias myproject='cd ~/projects/myproject'
```
