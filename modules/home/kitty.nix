{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    # Definiert die Schriftart für Kitty
    font = {
      name = "FiraCode Nerd Font";
      size = 11;
    };

    settings = {
      # --- Material Darker Farbpalette ---
      background           = "#212121";
      foreground           = "#eeffff";
      cursor               = "#80cbd8";
      selection_background = "#303030";
      selection_foreground = "#eeffff";

      # Die 16 Terminal-Farben (Normal / Bright)
      color0  = "#212121"; # Black
      color8  = "#4a4a4a";
      color1  = "#f07178"; # Red
      color9  = "#f07178";
      color2  = "#c3e88d"; # Green
      color10 = "#c3e88d";
      color3  = "#f78c6c"; # Yellow
      color11 = "#ffcb6b";
      color4  = "#82aaff"; # Blue
      color12 = "#82aaff";
      color5  = "#c792ea"; # Magenta
      color13 = "#c792ea";
      color6  = "#89ddff"; # Cyan
      color14 = "#89ddff";
      color7  = "#eeffff"; # White
      color15 = "#ffffff";

      # --- VeloxOS Niri- & Transparenz-Styling ---
      background_opacity      = "0.85";
      background_blur         = 1;
      window_padding_width    = 12;
      hide_window_decorations = "yes";
      confirm_os_window_close = 0;
      cursor_shape            = "underline";
      cursor_blink_interval   = "0.5";
      enable_audio_bell       = false;
      dynamic_background_opacity = "yes";
      
      linux_display_server    = "auto"; 
    };
  };
}
