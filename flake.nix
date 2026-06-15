{
  description = "VeloxOS - Declarative Gaming & Development OS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    
    nixosModules.default = ./modules;

    nixosConfigurations = {
      velox-iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"
          
          ./modules

          ({ config, pkgs, ... }: {
            veloxos.services.zram.enable = true;
            isoImage.isoName = "veloxos-unstable-${pkgs.stdenv.hostPlatform.system}.iso";
            nixpkgs.config.allowUnfree = true;
          })
        ];
      };
    };

  };
}
