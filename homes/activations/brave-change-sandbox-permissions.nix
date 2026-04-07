# As with vscode, we need to change some permissions due to sandboxing.
# Only for non-NixOS systems. This activation script fixes it.
{ lib, ... }:
{
  home.activation.braveChangeSandboxPermissions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    PATH="/usr/bin:/bin:$PATH"
    for path in $(ls /nix/store/*brave*/opt/brave.com/brave/chrome-sandbox)
    do
      run sudo chmod 4755 $path
    done
  '';
}
