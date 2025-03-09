{ lib, ... }: {
  home.activation.changeShell = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ $(uname -s ) == "Darwin" ]; then
      readlink() {
        greadlink "$@"
      }
      export -f readlink

      ln() {
        gln "$@"
      }
      export -f ln

      find() {
        gfind "$@"
      }
      PATH="/opt/homebrew/bin:/usr/bin:/bin:$PATH"
    else
      PATH="/usr/bin:/bin:$PATH"
    fi

    if [ ! -f ~/.shell-changed-flag ]; then
      run echo $(which zsh) | sudo tee -a /etc/shells
      run sudo chsh -s $(which zsh) $(whoami)
      run touch ~/.shell-changed-flag
    fi
  '';
}
