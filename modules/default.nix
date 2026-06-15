{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware/zram.nix
    ./gaming.nix
    ./system/gc.nix
  ];

  config = {
    # Dynamische Home-Manager-Zuweisung für alle echten System-User
    home-manager.users = lib.mapAttrs (username: user: {
      
      imports = [
        ./home/core.nix
        ./home/theme.nix
        ./home/niri.nix
        ./home/kitty.nix
      ];

      # Definiert die State-Version für den Home-Manager im User-Space
      home.stateVersion = "26.05";

    }) (lib.filterAttrs (name: user: user.isNormalUser) config.users.users);
  };
}
