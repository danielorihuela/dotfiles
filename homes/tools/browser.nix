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
in
{
  programs.chromium = {
    enable = true;
    package = if usePackage then pkgs.brave else null;
  };

}
