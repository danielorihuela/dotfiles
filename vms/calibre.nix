{ pkgs, ... }: {
  system.stateVersion = "24.11";

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096;
      cores = 2;
    };
  };

  users.users = {
    calibre = {
      isNormalUser = true;
      password = "calibre";
      extraGroups = [ "wheel" ];
    };
  };
  security.sudo.wheelNeedsPassword = false;
  services.getty.autologinUser = "calibre";

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [ calibre ];
}
