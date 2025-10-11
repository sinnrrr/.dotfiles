set fish_greeting

set -gx XDG_CONFIG_HOME "$HOME/.config" # for lazygit
set -gx PATH $PATH ~/.cargo/bin
set -gx PATH $PATH ~/.local/bin
set -gx PATH $PATH /opt/homebrew/bin

set -gx EDITOR hx
set -gx SHELL $(which fish)

function yazi
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function suyabai
    set str (whoami)" ALL = (root) NOPASSWD: sha256:"(shasum -a 256 (which yabai) | awk '{print $1;}')" "(which yabai)" --load-sa"
    echo $str | sudo tee /private/etc/sudoers.d/yabai
end

function fish_user_key_bindings
    bind \ce 'yazi; commandline -f repaint'
    bind \ee edit_command_buffer
end

function auto_activate_venv --on-variable PWD
    # Deactivate if we're in a venv but outside its directory
    if set -q VIRTUAL_ENV
        if not string match -q "$VIRTUAL_ENV*" "$PWD"
            deactivate
        end
    end

    # Activate venv if found in current directory
    if test -d venv
        source venv/bin/activate.fish
    else if test -d .venv
        source .venv/bin/activate.fish
    end
end

# Run once on shell startup for current directory
auto_activate_venv

if test -f (brew --prefix)/etc/brew-wrap.fish
    source (brew --prefix)/etc/brew-wrap.fish
end

if test -f ~/.local/.env.fish
    source ~/.local/.env.fish
end

fnm env --use-on-cd --shell fish | source

alias k kubectl
alias lg lazygit
alias ji "jira issue list -w -s~Done --order-by status"
alias k10s "devx login && devx mariner kubeconfig && k9s --context cp3-nonprod-main-us-east-1 --namespace winnie"
alias awsd "devx cloud aws-login -r 'arn:aws:iam::212883212683:role/bamazon-TeamInsights'"
