{
  lib,
  pkgs,
  osConfig,
  desktop,
  ...
}:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isNixOS = osConfig != null;
  usePackage = isLinux && isNixOS;
  isGnome = desktop == "gnome";
  isPlasma = desktop == "plasma";
in
lib.mkMerge [
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
        shell-integration-features = "ssh-env,ssh-terminfo";
      };
    };
  }
  (lib.optionalAttrs isGnome {
    dconf.settings = {
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ghostty/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ghostty" = {
        name = "Ghostty";
        command = "ghostty";
        binding = "<Ctrl><Super>t";
      };
    };
  })
  (lib.optionalAttrs isPlasma {
    programs.plasma.hotkeys.commands.ghostty = {
      command = "ghostty";
      key = "Ctrl+Meta+T";
    };
  })
]
