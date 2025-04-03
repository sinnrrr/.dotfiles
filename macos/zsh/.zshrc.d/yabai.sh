suyabai() {
    str="$(whoami) ALL = (root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | awk "{print \$1;}") $(which yabai) --load-sa"
    echo $str | sudo tee /private/etc/sudoers.d/yabai
}

postbrewyabai() {
    yabai --stop-service
    suyabai
    yabai --start-service
}

yabaiheadupdate() {
    yabai --stop-service
    sudo yabai --uninstall-sa
    pkill -x Dock
    brew reinstall koekeishiya/formulae/yabai
    codesign -fs "yabai-cert" "$(brew --prefix yabai)/bin/yabai"
    suyabai
    yabai --start-service
}

rmyabai() {
    yabai --uninstall-service
    sudo yabai --uninstall-sa
    brew uninstall yabai
    killall Dock
}
