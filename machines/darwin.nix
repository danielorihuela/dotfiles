{ ... }:

{
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 6;
  system.primaryUser = "dani";
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.dani = {
    name = "dani";
    home = "/Users/dani";
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    taps = [ "homebrew/cask" ];
    brews = [ "bash" "coreutils" "findutils" ];
    casks = [ "bitwarden" "cryptomator" "fuse-t" "ghostty" ];
  };
}
