nvim_restore_session_for_curr_dir() {
    nvim +"lua require('persistence').load()" # pwd is current lf dir
}

nvim_restore_last_session() {
    nvim +"lua require('persistence').load({ last = true })"
}

_zinit_nvim() {
    zle -N nvim_restore_session_for_curr_dir
    bindkey -M emacs '^O' nvim_restore_session_for_curr_dir
    bindkey -M vicmd '^O' nvim_restore_session_for_curr_dir
    bindkey -M viins '^O' nvim_restore_session_for_curr_dir

    bindkey -r '^P'
    zle -N nvim_restore_last_session
    bindkey -M emacs '^P' nvim_restore_last_session
    bindkey -M vicmd '^P' nvim_restore_last_session
    bindkey -M viins '^P' nvim_restore_last_session
}
