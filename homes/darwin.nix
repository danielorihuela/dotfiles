{ pkgs, ... }:

{
  imports = [
    ./tools/emacs.nix
    ./tools/ghostty.nix
    ./tools/git.nix
    ./tools/shell.nix
    ./tools/vscode.nix
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  home.username = "dani";
  home.homeDirectory = "/Users/dani";

  programs.firefox.enable = true;
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
  };
}
