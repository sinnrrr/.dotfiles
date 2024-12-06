# it's for changing dir on lf quit with button Q (not regular q)
lf() {
    local tempfile="$(mktemp)"
    command lf -command "map Q \$echo \$PWD >$tempfile; lf -remote \"send \$id quit\"" "$@"

    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n $(pwd))" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
}

lfp(){
    local TEMP=$(mktemp)
    lf -selection-path=$TEMP $@
    local PATHS=$(cat $TEMP)
    echo $PATHS
}

_zinit_lf() {
    bindkey -r '^E'
    bindkey -s '^E' 'lf^M'
}
