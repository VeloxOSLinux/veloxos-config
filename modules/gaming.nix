{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.veloxos.gaming;
in {
  # --- 1. Definition der Optionen ---
  options.veloxos.gaming = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Aktiviert die globalen VeloxOS Gaming-Optimierungen, Tools und Treiber-Anpassungen.";
    };

    steam = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Installiert Steam und konfiguriert die Firewall für Remote Play / Dedicated Server.";
      };
      gamescope = mkOption {
        type = types.bool;
        default = true;
        description = "Aktiviert die Gamescope-Session-Unterstützung für Steam (Micro-Compositor für bessere Performance/HDR).";
      };
    };

    gamemode = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Aktiviert Feral GameMode zur dynamischen Optimierung von CPU, GPU und Prozess-Prioritäten beim Spielen.";
      };
    };

    zram = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Aktiviert das optimierte VeloxOS zRAM-Modul für besseres Speichermanagement unter Last.";
      };
    };

    installDiscord = mkOption {
      type = types.bool;
      default = true;
      description = "Installiert den Discord-Client systemweit.";
    };
  };

  # --- 2. Umsetzung der Logik ---
  config = mkIf cfg.enable {
    
    # Steam-Konfiguration
    programs.steam = mkIf cfg.steam.enable {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = cfg.steam.gamescope;
    };

    # Feral GameMode
    programs.gamemode.enable = cfg.gamemode.enable;

    # Umgebungsvariable für ProtonUp-Qt / Custom Proton-Versionen (GE-Proton)
    environment.sessionVariables = mkIf cfg.steam.enable {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };

    # Systemweite Gaming-Pakete
    environment.systemPackages = with pkgs; [
      mangohud      # FPS & Hardware-Overlay
      faugus-launcher
    ] 
    ++ (optional cfg.steam.enable protonup-qt)
    ++ (optional cfg.installDiscord discord);
    
    veloxos.services.zram.enable = cfg.zram.enable;
  };
}
