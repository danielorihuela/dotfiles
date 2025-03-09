{ ... }:

{
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.dani = {
    name = "dani";
    home = "/Users/dani";
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    taps = [ ];
    brews = [ "bash" "coreutils" "findutils" ];
    casks = [ "ghostty" ];
  };
}
