{ pkgs, ... }:

{
  imports = [
    ./tools/emacs.nix
    ./tools/flameshot.nix
    ./tools/ghostty.nix
    ./tools/git.nix
    ./tools/neovim.nix
    ./tools/shell.nix
    ./tools/vscode.nix
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.username = "dani";
  home.homeDirectory = "/Users/dani";

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "teal";
  };

  programs.firefox.enable = true;
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
  };
}
