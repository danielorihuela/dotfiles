{ pkgs, ... }:
let
  commonUserSettings = {
    "workbench.colorTheme" = "Dracula Theme";
    "files.insertFinalNewline" = true;
    "terminal.integrated.defaultProfile.linux" = "zsh";
  };

  commonExtensions = with pkgs.vscode-extensions; [
    dracula-theme.theme-dracula
    eamodio.gitlens

    github.copilot
    github.copilot-chat

    rust-lang.rust-analyzer

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

    profiles.windows = {
      userSettings = commonUserSettings // {
        "rust-analyzer.cargo.target" = "aarch64-pc-windows-msvc";
      };
      extensions = commonExtensions;
    };
  };
}
