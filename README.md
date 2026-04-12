# dotfiles-vm

Lightweight dotfiles for Fedora VM environments (Lima, Digital Ocean etc.).

## Prerequisites

- **Ansible** - Version 2.10 or higher
- **Python 3** - Required by Ansible

The Ansible playbook will automatically install all other required tools.

## Installation

### Quick Install (Fedora)

```bash
# Clone the repository
git clone https://github.com/Aljendro/dotfiles-vm.git dotfiles
cd ~/dotfiles

# Install Ansible and required collections
sudo dnf install -y ansible

# Run the playbook
ansible-playbook install.yml
```

## What's Installed

### System Packages (via DNF)

- **zsh** - Default shell
- **stow** - Symlink farm manager
- **git** + **git-delta** - Version control with diff viewer
- **lazygit** - Terminal UI for git
- **neovim** - Editor
- **tmux** - Terminal multiplexer
- **fzf** - Fuzzy finder
- **fd-find** - Fast file finder
- **ripgrep** - Fast grep
- **bat** - Cat with syntax highlighting
- **jq** - JSON processor
- **xclip** - Clipboard support
- **xorg-x11-xauth** - X11 forwarding support
- **mise** - Runtime version manager (node, go, rust)
- **awscli2** - AWS CLI
- **clangd** - C/C++ language server
- **tree**, **lsof**, **curl**, **wget**, **unzip**

### Global npm Packages

- **neovim** - Neovim node provider
- **@anthropic-ai/claude-code** - Claude Code CLI
- **@github/copilot** - GitHub Copilot CLI
- **corepack** - Node.js package manager shim

### Managed Runtimes (via mise)

- **Node.js** 24
- **Go** (latest)
- **Rust** (latest)

## What's Included

### Zsh Configuration (`stow/zsh/`)

- `.zshrc` - Main shell configuration with:
  - Vi mode editing with cursor shape changes
  - FZF integration (file finder, directory changer, history search)
  - mise activation for global runtime management
  - Git-aware prompt
  - AWS CLI completion
  - Useful aliases
- `.zprofile` - Login shell setup
- `.zshrc_local.sample` - Template for local variables

### Git Configuration (`stow/git/`)

- `.gitconfig` - Git settings with:
  - Delta pager for diffs
  - Useful aliases
- `.gitignore_global` - Global gitignore patterns

### Tmux Configuration (`stow/tmux/`)

- `.config/tmux/tmux.conf` - Tmux settings with:
  - Prefix remapped to Ctrl+A
  - Vi keybindings

### Neovim Configuration (`stow/nvim/`)

- `.config/nvim/` - Neovim starter config (submodule)
- `~/.config/nvim-local/friendly-snippets` - Custom snippets (cloned separately)

### Other Tools

- `stow/ripgrep/.ripgrep` - Ripgrep defaults
- `bin/git_worktree_add` - Git worktree helper script
- `bin/tmux_switch` - Tmux session switcher script

## Key Bindings

### Zsh (Vi Mode)

- `Esc` - Enter command mode
- `k/j` - History search (command mode)
- `v` - Edit command in `$EDITOR` (command mode)
- `Ctrl+R` - FZF reverse history search
- `Ctrl+T` - FZF file finder
- `Alt+C` - FZF directory changer
- `Ctrl+P/N` - History navigation
- `Ctrl+A/E` - Beginning/end of line
- `Ctrl+W` - Delete word backward
- `Ctrl+L` - Clear screen

### Tmux

- `Ctrl+A` - Prefix
- `Prefix + f` - Enter copy mode
- `Prefix + t` - Fuzzy session switcher
- `Prefix + h/j/k/l` - Pane navigation
- `Prefix + v/s` - Split panes
- `Prefix + n/N` - New window

## SSH / X11 Forwarding

The playbook configures `/etc/ssh/ssh_config` with:

- `ForwardX11 yes`
- `ForwardX11Trusted no`

## Customization

Edit `~/.zshrc_local` for machine-specific settings (see `.zshrc_local.sample`).
