{ pkgs, ... }: {
  home.packages = with pkgs; [ nixfmt-classic ];

  programs.vscode = {
    enable = true;

    profiles.default = {
      userSettings = {
        "workbench.colorTheme" = "Dracula Theme";
        "files.insertFinalNewline" = true;
      };

      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        eamodio.gitlens

        jnoortheen.nix-ide
      ];
    };
  };
}
