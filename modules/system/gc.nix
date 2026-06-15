{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.veloxos.system.gc;
in {
  options.veloxos.system.gc = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Aktiviert die automatische VeloxOS Garbage Collection sowie die Store-Optimierung.";
    };

    minFreeGB = mkOption {
      type = types.int;
      default = 15;
      description = "Mindestens freier Speicherplatz auf der Partition in GB, bevor die GC-Notbremse greift.";
    };

    maxFreeGB = mkOption {
      type = types.int;
      default = 30;
      description = "Bis zu wie viel freiem Speicherplatz (in GB) alte Generationen bereinigt werden sollen.";
    };

    interval = mkOption {
      type = types.enum [ "weekly" "daily" ];
      default = "weekly";
      description = "Das Intervall, in dem der automatische Garbage-Collection-Timer läuft (weekly oder daily).";
    };
  };

  # --- 2. Umsetzung der Logik basierend auf den Optionen ---
  config = mkIf cfg.enable {
    # Automatische Store-Optimierung bleibt aktiv, solange GC enabled ist
    nix.settings.auto-optimise-store = true;

    # Die Speicherplatz-Notbremse (dynamisch umgerechnet von GB in Bytes)
    nix.settings = {
      min-free = cfg.minFreeGB * 1024 * 1024 * 1024;
      max-free = cfg.maxFreeGB * 1024 * 1024 * 1024;
    };

    # Der regelmäßige GC-Lauf
    nix.gc = {
      automatic = true;
      dates = cfg.interval; # Übergibt dynamisch "weekly" oder "daily"
      options = "--delete-older-than 30d";
    };

    # Desktop-Sicherheitsgurt für den GC-Timer
    systemd.timers."nix-gc".timerConfig = {
      Persistent = true;
      # Verhindert, dass der GC-Lauf direkt beim Systemstart die Performance beeinträchtigt
      RandomizedDelaySec = lib.mkForce "30m";
    };
  };
}
