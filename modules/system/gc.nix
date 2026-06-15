{ config, pkgs, ... }:

{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Verzögerung für den automatischen Start nach dem Booten
  systemd.timers."nix-gc".timerConfig = {
    Persistent = true;
    RandomizedDelaySec = pkgs.lib.mkForce "30m";
  };
}
