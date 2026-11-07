{
  pkgs,
  lib,
  username,
  isLinux,
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
  ]
  ++ lib.optionals isLinux [
    ./tools/wayscriber.nix
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.username = username;
  home.homeDirectory = if isLinux then "/home/${username}" else "/Users/${username}";
}
