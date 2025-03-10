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

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  home.username = "dorihuela";
  home.homeDirectory = "/Users/dorihuela";
}
