{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware/zram.nix
    ./gaming.nix
  ];
}
