#!/bin/bash
#
# Dotfiles-VM Installation Script
# Installs bash-based configurations for Ubuntu VM environment
#

set -e

DOTFILES_VM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles-vm from: $DOTFILES_VM_DIR"
echo ""

# Initialize and update submodules
echo "Initializing submodules..."
cd "$DOTFILES_VM_DIR"
git submodule update --init --recursive

# Stow packages
PACKAGES=(
    "bash"
    "git"
    "tmux"
    "ripgrep"
    "fzf"
    "nvim"
    "bin"
)

echo ""
echo "Stowing packages..."

for package in "${PACKAGES[@]}"; do
    echo "  - $package"
    stow -d "$DOTFILES_VM_DIR/stow" -t "$HOME" "$package" --restow
done

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Copy .bashrc_local template and add your secrets:"
echo "     cp ~/.bashrc_local ~/.bashrc_local.bak  # if exists"
echo "     # Edit ~/.bashrc_local with your API keys and local settings"
echo ""
echo "  2. Reload your shell:"
echo "     source ~/.bashrc"
echo ""
echo "  3. Install Neovim plugins (first launch will auto-install):"
echo "     nvim"
echo ""
