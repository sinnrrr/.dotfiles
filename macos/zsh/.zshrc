p10k_cache="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
if [[ -r $p10k_cache ]]; then
    source $p10k_cache
fi

SHELL="/bin/zsh" # skhd related fix, override back to zsh
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

[[ -n $(ls ~/.zshrc.d/) ]] && for file in ~/.zshrc.d/*; do source "${file}"; done

ZVM_VI_HIGHLIGHT_FOREGROUND=white
ZVM_VI_HIGHLIGHT_BACKGROUND=black
ZVM_CURSOR_STYLE_ENABLED=false
zstyle ':completion:*' menu select
zle_highlight+=(paste:none) # no highlight on paste

setopt autocd	interactive_comments
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

ZSH_AUTOSUGGEST_MANUAL_REBIND=1

zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit ice depth=1 atload'zvm_vi_yank() { zvm_yank; echo ${CUTBUFFER} | pbcopy; zvm_exit_visual_mode; }'
zinit light jeffreytse/zsh-vi-mode

# Regular plugins, loaded in turbe mode (wait)
zinit wait lucid light-mode for \
    OMZP::golang \
    OMZP::terraform \
    \
    as"completion" \
    OMZP::docker/completions/_docker \
    \
    as"completion" \
    OMZP::docker-compose/_docker-compose \
    \
    atload'bindkey "^[[A" history-substring-search-up; bindkey "^[[B" history-substring-search-down' \
    zsh-users/zsh-history-substring-search \
    \
    atload='_zinit_yazi' \
    id-as'yazi' nocompile \
    zdharma-continuum/null \
    \
    atload='_zinit_nvim' \
    id-as'nvim' nocompile \
    zdharma-continuum/null \
    \
    depth'1' as'null' nocompile \
    src'shell/key-bindings.zsh' \
    junegunn/fzf \
    \
    src"bin/aws_zsh_completer.sh" nocompile \
    aws/aws-cli \
    \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
    \
    blockf atclone'zinit creinstall -q $HOMEBREW_PREFIX/share/zsh/site-functions' atpull'%atclone' \
    zsh-users/zsh-completions \
    \
    atload"!_zsh_autosuggest_start; bindkey '^W' forward-word" \
    zsh-users/zsh-autosuggestions

autoload -U colors && colors

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
