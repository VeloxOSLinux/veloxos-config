{
  description = "VeloxOS - Declarative Gaming & Development OS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Hier werden später ISOs und Test-Systeme definiert
    nixosConfigurations = {
      # Platzhalter für erstes VeloxOS-System
    };
  };
}
