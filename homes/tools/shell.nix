{ pkgs, ... }: {
  home.sessionVariables = { EDITOR = "vi"; };

  programs.zsh = {
    enable = true;

    shellAliases = {
      cat = "bat --pager=never";
      less = ''bat --pager="less -RF"'';
    };
  };

  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;

      character = {
        success_symbol = "[➜](green)";
        error_symbol = "[✗](red)";
      };

      directory = {
        truncation_length = 1;
        fish_style_pwd_dir_length = 1;
      };
    };
  };

  programs.atuin.enable = true;

  programs.bat = {
    enable = true;
    config = { style = "full,-grid,-header-filename,-header-filesize"; };
  };

  programs.eza.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
