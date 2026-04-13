set fish_greeting

if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

set -gx XDG_CONFIG_HOME "$HOME/.config" # for lazygit
set -gx PATH $PATH ~/.cargo/bin
set -gx PATH ~/.local/bin $PATH
set -gx PATH $PATH "$HOME/.bun/bin"

set -gx EDITOR hx
set -gx SHELL $(which fish)

function envsource
    for line in (cat $argv | grep -v '^#' |  grep -v '^\s*$' | sed -e 's/=/ /' -e "s/'//g" -e 's/"//g' )
        set export (string split ' ' $line)
        set -gx $export[1] $export[2]
        echo "Exported key $export[1]"
    end
end

function yazi
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function work
    set -l selected (find ~/Work -mindepth 1 -maxdepth 1 -type d | sort | sed "s|$HOME/Work/||" | fzf --prompt="work> " --height=40% --reverse)
    if test -n "$selected"
        builtin cd ~/Work/$selected
        commandline -f repaint
        ai
    end
end

function fish_user_key_bindings
    bind \ce 'yazi; commandline -f repaint'
    bind \co 'ai; commandline -f repaint'
    bind \cw 'work; commandline -f repaint'
    bind \ee edit_command_buffer
end

function auto_activate_env --on-variable PWD
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
auto_activate_env

if test -f (brew --prefix)/etc/brew-wrap.fish
    source (brew --prefix)/etc/brew-wrap.fish
end

if test -f ~/.local/.env.fish
    source ~/.local/.env.fish
end

fnm env --use-on-cd --log-level=quiet --shell fish | source

alias k kubectl
alias tf terraform
alias lg lazygit
alias pip pip3
alias python python3
alias ghp "GH_HOST=github.twdcgrid.net gh dash"
alias ji "jira issue list -w -s~Done --order-by status"
alias k10s "devx login && devx mariner kubeconfig && k9s --context cp3-nonprod-main-us-east-1 --namespace winnie"
alias awsd "devx cloud aws-login -r 'arn:aws:iam::212883212683:role/bamazon-TeamInsights'"
