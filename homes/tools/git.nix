{ ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user.email = "danielorihuelarodriguez@gmail.com";
      github.user = "danielorihuela";

      alias = {
        la = "config --get-regexp alias";
        co = "checkout";
        cap = "!git commit --amend --no-edit && git push -f";
        cmp = "!git checkout $(git main-branch) && git pull";
        reset-hard = "!git reset --hard origin/$(git branch --show-current)";
        mm = "!f() { [ -n \"$1\" ] && git checkout \"$1\"; local main=$(git main-branch); git fetch origin \"$main\" && git merge --no-edit \"origin/$main\"; }; f";

        # These aliases are used to simplify other aliases
        # They are not supposed to be called directly
        main-branch = "!git branch --list main master --format='%(refname:short)' | head -n1";
      };
    };
  };
}
