{
  lib,
  pkgs,
  config,
  ...
}:
let
  isLinux = pkgs.stdenv.isLinux;
  isNixOS = config ? nixosVersion;
  usePackage = isLinux && isNixOS;
  useNativePackageManager = isLinux && !isNixOS;
in
{
  programs.chromium = {
    enable = true;
    package = if usePackage then pkgs.brave else null;
  };

  # Install Brave through apt in ubuntu to avoid sandbox permissions issues with `chrome-sandbox`.
  home.activation.installBraveFromNativePackageManager = lib.mkIf useNativePackageManager (
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      PATH="/usr/bin:/bin:$PATH"

      if command -v apt-get >/dev/null 2>&1 && ! command -v brave-browser >/dev/null 2>&1; then
        run sudo apt-get update
        run sudo apt-get install -y curl
        run sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
        run sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
        run sudo apt-get update
        run sudo apt-get install -y brave-browser
      fi
    ''
  );
}
