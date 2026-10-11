{
  lib,
  pkgs,
  desktop,
  ...
}:
let
  isGnome = desktop == "gnome";
  isPlasma = desktop == "plasma";
in
{
  home.packages = with pkgs; [
    wayscriber

    # Wayscriber dependencies for screenshot and clipboard tools (for wlroots compositors)
    grim
    slurp
    wl-clipboard
  ];
}
// lib.optionalAttrs isGnome {
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wayscriber/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wayscriber" = {
      name = "Wayscriber";
      command = "wayscriber --daemon-toggle";
      binding = "<Ctrl><Super>p";
    };
  };
}
// lib.optionalAttrs isPlasma {
  programs.plasma.hotkeys.commands.wayscriber = {
    command = "wayscriber --daemon-toggle";
    key = "Ctrl+Meta+P";
  };
}
