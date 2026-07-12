# Install some packages with apt
# ghostty - to avoid nixgl
{ lib, ... }:
{
  home.activation.installAptPackages = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    PATH="/usr/bin:/bin:$PATH"

    if command -v apt-get >/dev/null 2>&1; then
      if ! command -v ghostty >/dev/null 2>&1; then
        run sudo apt-get update
        run sudo apt-get install -y ghostty
      fi
    fi
  '';
}
