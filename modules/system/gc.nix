{ config, lib, pkgs, ... }:

{
  # 1. Automatische Store-Optimierung (Spart massiv Platz durch Hardlinks)
  nix.settings.auto-optimise-store = true;

  # 2. Die Speicherplatz-Notbremse (wird nur aktiv, wenn es eng wird)
  nix.settings = {
    min-free = 15 * 1024 * 1024 * 1024; # 15 GB in Bytes
    max-free = 30 * 1024 * 1024 * 1024; # 30 GB in Bytes
  };

  # 3. Der wöchentliche Sicherheits-Standard-Lauf
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # 4. Desktop-Sicherheitsgurt für den GC-Timer
  systemd.timers."nix-gc".timerConfig = {
    Persistent = true;
    RandomizedDelaySec = lib.mkForce "30m";
  };
}
