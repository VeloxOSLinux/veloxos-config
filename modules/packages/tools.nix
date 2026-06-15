{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.veloxos.tools;
in {
  # --- 1. Optionen für optionale, größere Stacks ---
  options.veloxos.tools = {
    development = {
      enableNixTools = mkOption {
        type = types.bool;
        default = true;
        description = "Installiert nützliche Werkzeuge für die NixOS-Entwicklung (nixd, alejandra).";
      };
    };
    
    virtualization = {
      docker = mkOption {
        type = types.bool;
        default = false;
        description = "Aktiviert den Docker-Systemdienst und die CLI-Tools.";
      };
    };
  };

  # --- 2. Umsetzung ---
  config = {
    
    # Docker-Dienst wird nur aktiv, wenn explizit gewünscht
    virtualisation.docker.enable = cfg.virtualization.docker;

    # Systemweite Pakete
    environment.systemPackages = with pkgs; [
      # Kern-Utilities
      git
      curl
      wget
      htop
      fastfetch
      steam-run
    ]
    # Optionaler Zusatz für Nix-Entwickler (Standard: true)
    ++ (optionals cfg.development.enableNixTools [
      alejandra
      nixd
    ]);
  };
}
