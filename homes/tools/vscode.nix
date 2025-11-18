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
      extensions = with pkgs.vscode-extensions;
        commonExtensions ++ [ rust-lang.rust-analyzer ];
    };

    profiles.windows = {
      userSettings = commonUserSettings // {
        "rust-analyzer.cargo.target" = "aarch64-pc-windows-msvc";
      };
      extensions = with pkgs.vscode-extensions;
        commonExtensions ++ [ rust-lang.rust-analyzer ];
    };

    profiles.golang = {
      userSettings = commonUserSettings;
      extensions = with pkgs.vscode-extensions;
        commonExtensions ++ [ golang.go ];
    };
  };
}
