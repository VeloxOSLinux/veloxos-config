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
        specialArgs = { inherit inputs; };
        
        modules = [
          # Das offizielle grafische Live-Image-Modul von NixOS (bringt Gnome/Calamares)
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"

          ({ config, pkgs, ... }: {
            zramSwap.enable = true; 
            
            isoImage.isoName = "veloxos-unstable-${pkgs.stdenv.hostPlatform.system}.iso";
            nixpkgs.config.allowUnfree = true;
          })
        ];
      };
    };
  };
}
