#!/bin/bash
set -e

if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
fi

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if ! command -v stow >/dev/null 2>&1; then
  brew install stow
fi
