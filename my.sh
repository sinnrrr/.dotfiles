#!/bin/bash
# shellcheck source-path=SCRIPTDIR

# Detect operating system
case "$(uname -s)" in
Linux*) OS_DIR="linux" ;;
Darwin*) OS_DIR="macos" ;;
CYGWIN* | MINGW32* | MSYS* | MINGW*)
  OS_DIR="windows"
  ;;
*)
  echo "ERROR: Unsupported operating system: $(uname -s)" >&2
  exit 1
  ;;
esac

mkdir -p "$HOME/.local/bin"

SCRIPT_PATH=$(dirname "$(realpath "$0")")

stow_all() {
  cd "$1" || exit 1
  local pkgs=(*/)
  stow --no-folding --adopt -t "$HOME" "${pkgs[@]%/}"
}

if [[ "$1" = "init" ]]; then
  sudo -v
  case "$OS_DIR" in
  macos) . "$SCRIPT_PATH/macos/preinstall.sh" ;;
  esac
fi

# --adopt: if a target got delinked (some tool rewrote a stowed file in
# place, replacing the symlink with a plain file), pull it back into the
# repo instead of aborting. No-op for targets already correctly symlinked.
stow_all "$SCRIPT_PATH/general"
stow_all "$SCRIPT_PATH/$OS_DIR"
if [ -d "$SCRIPT_PATH/work" ]; then
  stow_all "$SCRIPT_PATH/work"
fi

if [[ "$1" = "init" ]]; then
  case "$OS_DIR" in
  macos) . "$SCRIPT_PATH/macos/postinstall.sh" ;;
  esac
  if [ -f "$SCRIPT_PATH/work/postinstall.sh" ]; then
    # shellcheck source=/dev/null
    . "$SCRIPT_PATH/work/postinstall.sh"
  fi
fi

echo "Config sourced."
