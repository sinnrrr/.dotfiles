#!/bin/bash

# Detect operating system
case "$(uname -s)" in
    Linux*)     OS_DIR="linux" ;;
    Darwin*)    OS_DIR="macos" ;;
    CYGWIN*|MINGW32*|MSYS*|MINGW*)
        OS_DIR="windows" ;;
    *)
        echo "ERROR: Unsupported operating system: $(uname -s)" >&2
        exit 1 ;;
esac

# Process general and OS-specific directories
cd general && stow --no-folding -t "$HOME" *
cd "../$OS_DIR" && stow --no-folding -t "$HOME" *
