{ pkgs, config, ... }: {
  programs.ghostty = {
    enable = true;

    # Ghostty Nix package doesn't work on darwin
    # If on darwin, we return null. This is a hack to manage the config with home-manager but not install the package
    # Then, we check if we are in a non-NixOS linux system to confgiure nixGL wrapping.
    package = if pkgs.stdenv.isDarwin then
      null
    else if !(config ? nixosVersion) then
      config.lib.nixGL.wrap pkgs.ghostty
    else
      pkgs.ghostty;

    # Disable when package is null to avoid building errors
    installBatSyntax = !pkgs.stdenv.isDarwin;

    settings = {
      theme = "Dracula";
      font-size = 16;
      command = "zsh";
    };
  };
}
