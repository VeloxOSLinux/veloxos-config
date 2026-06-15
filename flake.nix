{
  description = "VeloxOS - Declarative Gaming & Development OS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    
    nixosModules.default = ./modules;

    nixosConfigurations = {
      velox-iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # Wir übergeben 'inputs' an die Module, falls sie diese brauchen
        specialArgs = { inherit inputs; };
        
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"
          
          home-manager.nixosModules.home-manager
        
          ./modules

          ({ config, pkgs, ... }: {
            veloxos.services.zram.enable = true;
            isoImage.isoName = "veloxos-unstable-${pkgs.stdenv.hostPlatform.system}.iso";
            nixpkgs.config.allowUnfree = true;
            
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          })
        ];
      };
    };
  };
}
