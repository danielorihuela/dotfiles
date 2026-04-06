{ pkgs, ... }:
{
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "teal";

    vscode.profiles = {
      "default".enable = true;
      "golang".enable = true;
      "windows".enable = true;
    };
  };
}
