{
  description = "Machines configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = { url = "github:zhaofengli/nix-homebrew"; };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, darwin, nix-homebrew, nixgl, plasma-manager, ... }:
    let
      overlay-bat = final: prev: {
        bat = (import nixpkgs-stable {
          system = final.stdenv.hostPlatform.system;
        }).bat;
      };

      darwinHelpers = import ./helpers/darwin.nix {
        inherit nixpkgs darwin home-manager nix-homebrew overlay-bat;
      };
    in {

      homeConfigurations."dani" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          overlays = [ overlay-bat ];
        };
        modules = [ ./homes/linux.nix ];
        extraSpecialArgs = { inherit nixgl; };
      };

      darwinConfigurations."dani" = darwinHelpers.darwinConfiguration {
        username = "dani";
        machineFilePath = ./machines/darwin.nix;
        homeFilePath = ./homes/darwin.nix;
      };

      darwinConfigurations."nr" = darwinHelpers.darwinConfiguration {
        username = "dorihuela";
        machineFilePath = ./machines/nr.nix;
        homeFilePath = ./homes/nr.nix;
      };

      nixosConfigurations.calibre-vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./vms/calibre.nix ];
      };
      packages.x86_64-linux.calibre-vm =
        self.nixosConfigurations.calibre-vm.config.system.build.vm;

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/nixos.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            home-manager.users.dani = ./homes/nixos.nix;
          }
        ];
      };
    };
}
