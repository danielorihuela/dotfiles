{
  description = "Home Manager configuration of linuxlite";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };
  };

  outputs = { self, nixpkgs, home-manager, system-manager, nix-system-graphics
    , darwin, nix-homebrew, ... }: {

      homeConfigurations."dani" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        modules = [ ./homes/linux.nix ];
      };

      # Run graphics accelerated programs built with Nix on any Linux distribution
      systemConfigs.default = system-manager.lib.makeSystemConfig {
        modules = [
          nix-system-graphics.systemModules.default
          ({
            config = {
              nixpkgs.hostPlatform = "x86_64-linux";
              system-manager.allowAnyDistro = true;
              system-graphics.enable = true;
            };
          })
        ];
      };

      darwinConfigurations."dani" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
        modules = [
          ./machines/darwin.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.dani.imports = [ ./homes/darwin.nix ];
            };
          }

          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;
              user = "dani";
            };
          }

        ];
      };

      darwinConfigurations."nr" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
        modules = [
          ./machines/nr.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.dorihuela.imports = [ ./homes/nr.nix ];
              backupFileExtension = "backup";
            };
          }

          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;
              user = "dorihuela";
            };
          }

        ];
      };

      nixosConfigurations.calibre-vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./vms/calibre.nix ];
      };
      packages.x86_64-linux.calibre-vm =
        self.nixosConfigurations.calibre-vm.config.system.build.vm;

    };
}
