function yazi() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

function yazi_zed() {
  local tmp=$(mktemp -t "yazi-chooser.XXXXX")
  yazi "$@" --chooser-file="$tmp"
  local opened_file=$(head -n 1 "$tmp")
  zed -- "$opened_file"
  rm -f -- "$tmp"
}

_zinit_yazi() {
  bindkey -r '^E'
  bindkey -s '^E' 'yazi^M'
}
