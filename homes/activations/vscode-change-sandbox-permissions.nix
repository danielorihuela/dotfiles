# Installing vscode with Nix on a non-NixOS doesn't work out of the box.
# The app won't launch because the `chrome-sandbox` binary is not properly configured.
# Running `code --verbose .` shows the following error:
#
# [47161:0406/142223.670841:FATAL:sandbox/linux/suid/client/setuid_sandbox_host.cc:166]
# The SUID sandbox helper binary was found, but is not configured correctly. Rather than run without sandboxing I'm aborting now.
# You need to make sure that /nix/store/xc7y53y1la52bm3zr2waxqsyyinw3mfi-vscode-1.113.0/lib/vscode/chrome-sandbox is owned by root and has mode 4755.
#
# This activation script makes sure that the owner and permissions of the binary are as expected.
#
# Visual Studio Code Process Sandboxing - https://code.visualstudio.com/blogs/2022/11/28/vscode-sandbox.
{ lib, ... }:
{
  home.activation.vscodeChangeSandboxPermissions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    PATH="/usr/bin:/bin:$PATH"
    for path in $(ls /nix/store/*vscode*/lib/vscode/chrome-sandbox)
    do
      run sudo chmod 4755 $path
    done
  '';
}
