{ pkgs, ... }: {
  home.packages = with pkgs; [ nerd-fonts.symbols-only ];
  fonts.fontconfig.enable = true;

  home.file = {
    ".emacs.d" = {
      source = ../../emacs/.emacs.d;
      recursive = true;
    };
  };

  programs.emacs.enable = true;
}
