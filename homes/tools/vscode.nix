{ pkgs, ... }:
let
  commonUserSettings = {
    "workbench.colorTheme" = "Dracula Theme";
    "files.insertFinalNewline" = true;
    "terminal.integrated.defaultProfile.linux" = "zsh";
    "terminal.integrated.stickyScroll.enabled" = false;
    "update.mode" = "none";
  };

  commonExtensions = with pkgs.vscode-extensions; [
    dracula-theme.theme-dracula
    eamodio.gitlens

    github.copilot
    github.copilot-chat

    jnoortheen.nix-ide
  ];
in {
  home.packages = with pkgs; [ nixfmt-classic ];

  programs.vscode = {
    enable = true;

    profiles.default = {
      userSettings = commonUserSettings;
      extensions = commonExtensions;
    };

    profiles.golang = {
      userSettings = commonUserSettings;
      extensions = with pkgs.vscode-extensions;
        commonExtensions ++ [ golang.go ];
    };
  };
}
