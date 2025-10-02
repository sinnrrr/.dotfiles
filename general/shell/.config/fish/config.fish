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

function fish_user_key_bindings
    bind \ce 'yazi; commandline -f repaint'
    bind \ee edit_command_buffer
end

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
