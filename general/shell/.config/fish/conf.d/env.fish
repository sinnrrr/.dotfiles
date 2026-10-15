source ~/.config/shell/env.sh

if test -x /opt/homebrew/bin/brew
    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
    set -gx HOMEBREW_REPOSITORY /opt/homebrew
    fish_add_path -gmP /opt/homebrew/bin /opt/homebrew/sbin
    if set -q MANPATH
        set -gx MANPATH (string replace -r '^:*(.*?):*$' ':$1' -- "$MANPATH")
    end
    if not contains /opt/homebrew/share/info $INFOPATH
        set -gx INFOPATH /opt/homebrew/share/info $INFOPATH ''
    end
end

fish_add_path -gP ~/.local/bin "$HOMEBREW_PREFIX/opt/rustup/bin"
fish_add_path -gaP "$CARGO_HOME/bin" "$BUN_INSTALL/bin" ~/.bun/bin
