set fish_greeting

if type -q zoxide
    zoxide init fish | source
end

if type -q wt
    wt config shell init fish | source
end

if type -q fzf
    fzf --fish | source
end

fish_config theme choose catppuccin-mocha
set -g fish_prompt_pwd_dir_length 0

set -gx HOMEBREW_BREWFILE_LEAVES 1
set -gx HOMEBREW_BREWFILE_FORM file
set -gx HOMEBREW_BREWFILE_APPSTORE 1

function yazi
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function lg
    set -l out (mktemp -t "lazygit-cd-out.XXXXXX")
    LAZYGIT_CD_FILE=$out command lazygit-cd $argv
    set -l dir (cat -- $out 2>/dev/null)
    rm -f -- $out
    if test -n "$dir"
        builtin cd -- "$dir"
    end
end

function work
    set -l selected (find ~/Work -mindepth 1 -maxdepth 1 -type d | sort | sed "s|$HOME/Work/||" | fzf --prompt="work> " --height=40% --reverse)
    if test -n "$selected"
        builtin cd ~/Work/$selected
        commandline -f repaint
        $CODING_AGENT
    end
end

function fish_user_key_bindings
    bind \ce 'yazi; commandline -f repaint'
    bind \co '$CODING_AGENT; commandline -f repaint'
    bind \cw 'work; commandline -f repaint'
end

if test -f "$HOMEBREW_PREFIX/etc/brew-wrap.fish"
    source "$HOMEBREW_PREFIX/etc/brew-wrap.fish"
end

if test -f ~/.local/.env.fish
    source ~/.local/.env.fish
end

alias k kubectl
alias tf terraform
alias gs git-spice
# bfc <nothing>  - clean per Brewfile diff (old behaviour, interactive).
# bfc pkg...     - HOMEBREW_BREWFILE_LEAVES=1 means plain clean derives
#   "wanted" from currently installed leaves, not Brewfile text, so it can
#   never remove a dependency-only formula no matter what the file says.
#   Naming packages here uninstalls them directly instead, then dumps.
function bfc
    if test (count $argv) -gt 0; and not string match -q -- '-*' $argv[1]
        brew uninstall $argv
        and brew file dump -y
    else
        brew file clean $argv
    end
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
