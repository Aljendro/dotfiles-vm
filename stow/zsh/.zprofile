# ~/.zprofile - Executed for login shells
# Source .zshrc to ensure consistent environment

if [[ -f "$HOME/.zshrc" ]]; then
    source "$HOME/.zshrc"
fi
