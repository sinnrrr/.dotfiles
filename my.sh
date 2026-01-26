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
  . "$SCRIPT_PATH/$OS_DIR/preinstall.sh"
fi

# Process general and OS-specific directories
cd "$SCRIPT_PATH/general" && stow -t "$HOME" */
cd "$SCRIPT_PATH/$OS_DIR" && stow -t "$HOME" */

if [[ "$1" = "init" ]]; then
  . "$SCRIPT_PATH/$OS_DIR/postinstall.sh"
fi

echo "Config sourced."
