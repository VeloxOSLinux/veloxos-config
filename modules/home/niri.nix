{ config, pkgs, ... }:

{
  xdg.configFile."niri/config.kdl".source = ../../dotfiles/niri-config.kdl;
  home.file.".wallpaper.jpg".source = ../../wallpapers/wallpaper.jpg;
}
