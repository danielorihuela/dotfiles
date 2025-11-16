{ pkgs, nixgl, ... }:

{
  imports = [
    ./tools/emacs.nix
    ./tools/ghostty.nix
    ./tools/git.nix
    ./tools/shell.nix
    ./tools/vscode.nix
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.username = "dani";
  home.homeDirectory = "/home/dani";

  programs.plasma = {
    enable = true;

    workspace = {
      wallpaper = "/etc/.background/.background-image";
      iconTheme = "tela-icon-theme";
    };
  };

  programs.firefox.enable = true;
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
  };
}
