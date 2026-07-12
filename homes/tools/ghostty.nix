{ pkgs, config, ... }:
let
  usePackage = !pkgs.stdenv.isDarwin && config ? nixosVersion;
in
{
  programs.ghostty = {
    enable = true;
    systemd.enable = usePackage;

    # Ghostty Nix package doesn't work on darwin.
    # On non-NixOS Linux, Ghostty is installed through apt instead of Nix.
    package = if usePackage then pkgs.ghostty else null;

    # Disable when package is null to avoid building errors.
    installBatSyntax = usePackage;

    settings = {
      font-size = 16;
      command = "zsh";
      mouse-scroll-multiplier = 10;
    };
  };
}
