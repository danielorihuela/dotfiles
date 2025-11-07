{ nixpkgs, darwin, home-manager, nix-homebrew }: {
  darwinConfiguration = { username, machineFilePath, homeFilePath }:
    darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };

      modules = [
        machineFilePath
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username}.imports = [ homeFilePath ];
            backupFileExtension = "backup";
          };
        }

        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;
            user = username;
          };
        }
      ];
    };
}
