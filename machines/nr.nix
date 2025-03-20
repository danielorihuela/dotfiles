{ ... }:

{
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.dorihuela = {
    name = "dorihuela";
    home = "/Users/dorihuela";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;

    taps = [ ];
    brews = [ "bash" "coreutils" "findutils" "awscli" "ansible" "ctlptl" "gpg" "helm" "minikube" "pinentry-mac" "rustup" "terraform" "tilt"];
    casks = [ "ghostty" ];
  };
}
