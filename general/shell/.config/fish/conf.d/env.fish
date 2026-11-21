source ~/.config/shell/env.sh

if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv fish | source
end

fish_add_path -gP ~/.local/bin "$HOMEBREW_PREFIX/opt/rustup/bin"
fish_add_path -gaP "$CARGO_HOME/bin" "$BUN_INSTALL/bin"
