{ config, lib, pkgs, ... }:

{
  imports = [
    ./nixos-hardware.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager = {
    ly = {
      enable = true;
      settings.animation = "matrix";
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    tela-icon-theme
  ];

  system.stateVersion = "25.05";
  
  users.users.dani = {
    home = "/home/dani";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialHashedPassword = "$6$UmeRYWqt20jmqp9U$qpPkGTDdsm9X7yzVXhXg/EEYx3yxIZ5D7PbwCx3V9BDDysREzoNoPIOif5lUsXTvMhf8y4b7CfQMP7NdOMVT3/";
  };

  environment.etc.backgroundImage = {
    source = "/home/dani/dotfiles/backgrounds/deer.jpg";
    target = ".background/.background-image";
  };
}
