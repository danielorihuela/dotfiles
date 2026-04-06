{ pkgs, ... }:

{
  imports = [
    ./tools/emacs.nix
    ./tools/catppuccin.nix
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
  home.homeDirectory = "/home/dani";

  programs.plasma = {
    enable = true;

    kscreenlocker.appearance.wallpaper = "/etc/.background/.background-image";

    workspace = {
      wallpaper = "/etc/.background/.background-image";
      iconTheme = "Papirus-Dark";
    };

    hotkeys = {
      commands = {
        "flameshot" = {
          command = "flameshot gui";
          key = "Meta+S";
        };
      };
    };
  };

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
  };
}
