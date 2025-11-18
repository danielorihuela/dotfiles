{ pkgs, ... }:

{
  imports = [
    ./tools/emacs.nix
    ./tools/ghostty.nix
    ./tools/git.nix
    ./tools/shell.nix
    ./tools/vscode.nix

    ./activations/zsh-as-default-shell.nix
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.username = "dorihuela";
  home.homeDirectory = "/Users/dorihuela";
  home.sessionPath = [ "$HOME/.cargo/bin" "$HOME/.rd/bin" ];
}
