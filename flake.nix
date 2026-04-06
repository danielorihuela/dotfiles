{
  description = "Machines configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/843d505e4ae5f9237c1d10b57cc1ccda6128fd6e";

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

  outputs = { self, nixpkgs, home-manager, darwin, nix-homebrew, nixgl
    , plasma-manager, ... }:
    let
      darwinHelpers = import ./helpers/darwin.nix {
        inherit nixpkgs darwin home-manager nix-homebrew;
      };

      sharedModules = [
        self.inputs.catppuccin.homeModules.catppuccin
        self.inputs.nvf.homeManagerModules.default
      ];
    in {

      homeConfigurations."dani" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        modules = [ ./homes/linux.nix ] ++ sharedModules;
        extraSpecialArgs = { inherit nixgl; };
      };

      darwinConfigurations."dani" = darwinHelpers.darwinConfiguration {
        username = "dani";
        machineFilePath = ./machines/darwin.nix;
        homeFilePath = ./homes/darwin.nix;
        homeManagerModules = sharedModules;
      };

      darwinConfigurations."nr" = darwinHelpers.darwinConfiguration {
        username = "dorihuela";
        machineFilePath = ./machines/nr.nix;
        homeFilePath = ./homes/nr.nix;
        homeManagerModules = sharedModules;
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
            home-manager.sharedModules =
              [ plasma-manager.homeModules.plasma-manager ];
            home-manager.users.dani = {
              imports = [ ./homes/nixos.nix ] ++ sharedModules;
            };
          }
        ];
      };
    };
}
