source "$HOME/.config/shell/env.sh"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
typeset -U path PATH
path=("$HOME/.local/bin" $path)
export PATH
[[ -n $CLAUDECODE && -n $ZSH_EXECUTION_STRING && -r $HOME/.agents/shell/agent.zsh ]] && source "$HOME/.agents/shell/agent.zsh"
