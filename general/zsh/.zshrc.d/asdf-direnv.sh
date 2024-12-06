_zinit_asdf_install() {
    # path export temporary required so the asdf script finds itself
    PATH="${PWD}/bin:$PATH"
    # see https://github.com/asdf-community/asdf-direnv#setup
    pushd $HOME
    cat ./.tool-versions | awk '{print $1}' | xargs -I _ asdf plugin add _
    asdf install
    asdf exec direnv allow
    popd
    asdf exec direnv hook zsh >asdf_direnv_hook.zsh
    echo "✅ [asdf] installed!"
}
