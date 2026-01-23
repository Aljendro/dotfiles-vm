# FZF bash integration
# Setup fzf installed via apt on Ubuntu/Debian

# Auto-completion
# ---------------
if [[ $- == *i* ]]; then
  if [[ -f "/usr/share/bash-completion/completions/fzf" ]]; then
    source "/usr/share/bash-completion/completions/fzf"
  elif [[ -f "/usr/share/fzf/completion.bash" ]]; then
    source "/usr/share/fzf/completion.bash"
  fi
fi

# Key bindings (Ctrl-T, Ctrl-R, Alt-C)
# ------------------------------------
if [[ -f "/usr/share/doc/fzf/examples/key-bindings.bash" ]]; then
  source "/usr/share/doc/fzf/examples/key-bindings.bash"
elif [[ -f "/usr/share/fzf/key-bindings.bash" ]]; then
  source "/usr/share/fzf/key-bindings.bash"
fi
