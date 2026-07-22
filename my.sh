#!/bin/bash

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

mkdir -p $HOME/.local/bin

SCRIPT_PATH=$(dirname "$(realpath "$0")")

if [[ "$1" = "init" ]]; then
  sudo -v
  . "$SCRIPT_PATH/$OS_DIR/preinstall.sh"
fi

# --adopt: if a target got delinked (some tool rewrote a stowed file in
# place, replacing the symlink with a plain file), pull it back into the
# repo instead of aborting. No-op for targets already correctly symlinked.
cd "$SCRIPT_PATH/general" && stow --no-folding --adopt -t "$HOME" */
cd "$SCRIPT_PATH/$OS_DIR" && stow --no-folding --adopt -t "$HOME" */
if [ -d "$SCRIPT_PATH/work" ]; then
  cd "$SCRIPT_PATH/work" && stow --no-folding --adopt -t "$HOME" */
fi

if [[ "$1" = "init" ]]; then
  . "$SCRIPT_PATH/$OS_DIR/postinstall.sh"
  if [ -f "$SCRIPT_PATH/work/postinstall.sh" ]; then
    . "$SCRIPT_PATH/work/postinstall.sh"
  fi
fi

echo "Config sourced."
