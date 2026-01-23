# dotfiles-vm

Lightweight bash-based dotfiles for Ubuntu 24.04 LTS VM environments (Lima, etc.).

## Prerequisites

This configuration expects the following tools to be installed (via cloud-init or manually):

- **stow** - Symlink farm manager
- **git** - Version control
- **nvim** - Neovim editor
- **tmux** - Terminal multiplexer
- **fzf** - Fuzzy finder (apt install)
- **fd** - Fast file finder
- **ripgrep** - Fast grep
- **bat** - Cat with syntax highlighting
- **delta** - Git diff viewer
- **xclip** - Clipboard support

## Installation

```bash
# Clone the repository
git clone https://github.com/Aljendro/dotfiles-vm.git ~/projects/dotfiles-vm

# Run the installer
cd ~/projects/dotfiles-vm
./install.sh
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
  - Libsecret credential helper
  - Useful aliases
- `.gitignore_global` - Global gitignore patterns

### Tmux Configuration (`stow/tmux/`)
- `.tmux.conf` - Tmux settings with:
  - Prefix remapped to Ctrl+A
  - Vi keybindings
  - Mouse support
  - Powerline theme
- `.tmux-themepack/` - Theme submodule

### Neovim Configuration (`stow/nvim/`)
- `.config/nvim/` - Neovim starter config (submodule)

### Other Tools
- `stow/ripgrep/.ripgrep` - Ripgrep defaults
- `stow/fzf/.fzf.bash` - FZF bash integration
- `stow/bin/bin/` - Utility scripts

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

## Lima VM Setup

This repo is designed to work with Lima VMs. See the Lima configuration in the main dotfiles repo:
- `~/projects/dotfiles/stow/lima/.lima/vm/lima.yaml`
- `~/projects/dotfiles/stow/lima/.lima/vm/cloud-init.yaml`

Start VM: `limactl start vm`
Enter VM: `limactl shell vm`
