{
  lib,
  pkgs,
  config,
  desktop,
  ...
}:
let
  isLinux = pkgs.stdenv.isLinux;
  isNixOS = config ? nixosVersion;
  usePackage = isLinux && isNixOS;
  useNativePackageManager = isLinux && !isNixOS;
  isGnome = desktop == "gnome";
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

  # Install Ghostty through apt in ubuntu to avoid having to use nixgl.
  home.activation.installGhosttyFromNativePackageManager = lib.mkIf useNativePackageManager (
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      PATH="/usr/bin:/bin:$PATH"

      if command -v apt-get >/dev/null 2>&1 && ! command -v ghostty >/dev/null 2>&1; then
        run sudo apt-get update
        run sudo apt-get install -y ghostty
      fi
    ''
  );

  dconf.settings = lib.mkIf isGnome {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ghostty/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ghostty" = {
      name = "Ghostty";
      command = "ghostty";
      binding = "<Super>t";
    };
  };
}
