{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    ripgrep
    fd
    curl
  ];
}
