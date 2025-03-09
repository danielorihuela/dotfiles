{ lib, ... }: {
  home.activation.changeSandboxPermissions =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      PATH="/usr/bin:/bin:$PATH"
      for path in $(ls /nix/store/*vscode*/lib/vscode/chrome-sandbox)
      do
        run sudo chmod 4755 $path
      done
    '';
}
