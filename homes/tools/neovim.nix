{ ... }: {
  programs.nvf = {
    enable = true;

    settings.vim = {
      viAlias = true;
      vimAlias = true;

      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };

      lsp.enable = true;
      
      languages = {
        enableTreesitter = true;

        nix.enable = true;
      };
    };
  };
}
