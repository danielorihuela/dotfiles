{
  pkgs,
  username,
  ...
}:

{
  imports = [
    ./tools/browser.nix
    ./tools/emacs.nix
    ./tools/catppuccin.nix
    ./tools/flameshot.nix
    ./tools/ghostty.nix
    ./tools/git.nix
    ./tools/neovim.nix
    ./tools/shell.nix
    ./tools/vscode.nix

    ./activations/apt.nix
    ./activations/vscode-change-sandbox-permissions.nix
    ./activations/brave-change-sandbox-permissions.nix
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.username = username;
  home.homeDirectory = "/home/${username}";
}
