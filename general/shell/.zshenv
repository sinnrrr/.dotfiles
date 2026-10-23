source "$HOME/.config/shell/env.sh"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
typeset -U path PATH
path=("$HOME/.local/bin" $path)
export PATH
