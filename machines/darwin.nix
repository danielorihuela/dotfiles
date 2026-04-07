{ username, ... }:

{
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 6;
  system.primaryUser = username;
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    taps = [ "homebrew/cask" ];
    brews = [
      "bash"
      "coreutils"
      "findutils"
    ];
    casks = [
      "bitwarden"
      "cryptomator"
      "fuse-t"
      "ghostty"
    ];
  };
}
