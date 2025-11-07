{ ... }:

{
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 6;
  system.primaryUser = "dorihuela";
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.dorihuela = {
    name = "dorihuela";
    home = "/Users/dorihuela";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;

    taps = [ "homebrew/bundle" ];
    brews = [
      "bash"
      "coreutils"
      "findutils"
      "awscli"
      "ansible"
      "ctlptl"
      "gpg"
      "helm"
      "minikube"
      "pinentry-mac"
      "rustup"
      "terraform"
      "tilt"
      "helm-docs"
    ];
    casks = [ "ghostty" ];
  };
}
