{
  description = "Machines configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      darwin,
      nix-homebrew,
      nixgl,
      plasma-manager,
      ...
    }:
    let
      darwinHelpers = import ./helpers/darwin.nix {
        inherit
          nixpkgs
          darwin
          home-manager
          nix-homebrew
          ;
      };

      sharedModules = [
        self.inputs.catppuccin.homeModules.catppuccin
        self.inputs.nvf.homeManagerModules.default
      ];

      nonNixosUsers = {
        base = {
          username = "dani";
          homeFilePath = ./homes/linux.nix;
        };
      };

      darwinUsers = {
        base = {
          username = "dani";
          homeFilePath = ./homes/darwin.nix;
          machineFilePath = ./machines/darwin.nix;
        };
        nr = {
          username = "dorihuela";
          homeFilePath = ./homes/nr.nix;
          machineFilePath = ./machines/nr.nix;
        };
      };

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
    in
    {

      homeConfigurations = builtins.mapAttrs (
        key: data:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [ data.homeFilePath ] ++ sharedModules;
          extraSpecialArgs = {
            inherit nixgl;
            username = data.username;
          };
        }
      ) nonNixosUsers;

      darwinConfigurations = builtins.mapAttrs (
        key: data:
        darwinHelpers.darwinConfiguration {
          username = data.username;
          machineFilePath = data.machineFilePath;
          homeFilePath = data.homeFilePath;
          homeManagerModules = sharedModules;
        }
      ) darwinUsers;

      nixosConfigurations.calibre-vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./vms/calibre.nix ];
      };
      packages.x86_64-linux.calibre-vm = self.nixosConfigurations.calibre-vm.config.system.build.vm;

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/nixos.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            home-manager.users.dani = {
              imports = [ ./homes/nixos.nix ] ++ sharedModules;
            };
          }
        ];
      };

      apps = nixpkgs.lib.genAttrs systems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          build-config = {
            type = "app";
            program = "${
              pkgs.writeShellApplication {
                name = "build-config";
                text = ''
                  if [ "$OSTYPE" == "linux-gnu" ]; then
                      if ! command -v home-manager > /dev/null 2>&1; then
                          nix run home-manager/master -- init --switch --flake .#"$1"
                      else
                          home-manager switch --flake .#"$1"
                      fi
                  elif [ "$OSTYPE" == "darwin" ]; then
                      if ! command -v darwin-rebuild > /dev/null 2>&1; then
                          sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#"$1"
                      else
                          sudo darwin-rebuild switch --flake .#"$1"
                      fi
                  else 
                      echo "Unsupported OS: $OSTYPE"
                  fi
                '';
              }
            }/bin/build-config";
          };

          uninstall = {
            type = "app";
            program = "${
              pkgs.writeShellApplication {
                name = "uninstall";
                text = ''
                  if [ "$OSTYPE" == "darwin" ]; then
                      nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
                  fi
                  /nix/nix-installer uninstall
                '';
              }
            }/bin/uninstall";
          };
        }
      );

    };
}
