{ ... }:

{
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.dorihuela = {
    name = "dorihuela";
    home = "/Users/dorihuela";
  };

  homebrew = {
    enable = true;

    taps = [ ];
    brews = [ "bash" "coreutils" "findutils" "awscli" "ansible" "gpg" "pinentry-mac" "terraform"];
    casks = [ "ghostty" ];
  };
}
