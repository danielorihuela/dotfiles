{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;

    # Ghostty Nix package doesn't work on darwin
    # This is a hack to manage the config with home-manager but not install the package
    package = pkgs.lib.mkIf pkgs.stdenv.isDarwin null;

    # Disable when package is null to avoid building errors
    installBatSyntax = !pkgs.stdenv.isDarwin;

    settings = {
      theme = "Dracula";
      font-size = 16;
      command = "zsh";
    };
  };
}
