{
  pkgs,
  username,
  ...
}:

{
  imports = [
    ./tools/emacs.nix
    ./tools/catppuccin.nix
    ./tools/ghostty.nix
    ./tools/git.nix
    ./tools/neovim.nix
    ./tools/shell.nix
    ./tools/vscode.nix
    ./tools/wayscriber.nix
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.username = username;
  home.homeDirectory = "/home/${username}";
}
