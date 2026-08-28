{ ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user.email = "danielorihuelarodriguez@gmail.com";
      github.user = "danielorihuela";
    };

    aliases = {
      la = "config --get-regexp alias";
      co = "checkout";
      cap = "!git commit --amend --no-edit && git push -f";
      cmp = "!git checkout $(git branch --list main master --format='%(refname:short)' | head -n1) && git pull";
      reset-hard = "!git reset --hard origin/$(git branch --show-current)";
    };
  };
}
