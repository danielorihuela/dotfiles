{ pkgs, nixgl, ... }:

{
  imports = [
    ./tools/emacs.nix
    ./tools/flameshot.nix
    ./tools/ghostty.nix
    ./tools/git.nix
    ./tools/neovim.nix
    ./tools/shell.nix
    ./tools/vscode.nix

    ./activations/vscode-change-sandbox-permissions.nix
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.username = "dani";
  home.homeDirectory = "/home/dani";

  targets.genericLinux.nixGL = {
    packages = import nixgl { inherit pkgs; };
    defaultWrapper = "mesa";
    installScripts = [ "mesa" ];
  };

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
