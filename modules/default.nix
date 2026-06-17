{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware/zram.nix
    ./system/gc.nix
    ./system/system-settings.nix
    ./gaming.nix
    ./packages/tools.nix
  ];

  config = {
    home-manager.users = 
      let
        normalUsers = lib.filterAttrs (name: user: name != "nixos" && user.isNormalUser) config.users.users;
      in
        if normalUsers == {} then {} else
        lib.mapAttrs (username: user: {
          
          imports = [
            ./home/core.nix
            ./home/theme.nix
            ./home/niri.nix
            ./home/kitty.nix
          ];

          home.stateVersion = "26.05";

        }) normalUsers;
  };
}
