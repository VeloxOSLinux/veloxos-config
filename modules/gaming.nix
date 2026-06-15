{ config, pkgs, ... }:

{
  # Gaming Software & Optimierungen
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  # Gamemode für bessere CPU/GPU-Priorisierung in Spielen
  programs.gamemode.enable = true;

  environment.sessionVariables = {
  STEAM_EXTRA_COMPAT_TOOLS_PATHS =
    "\${HOME}/.steam/root/compatibilitytools.d";
 };

  # ZRAM-Modul aktivieren
  veloxos.services.zram.enable = true;

  # Zusätzliche Gaming-Tools
  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
    faugus-launcher
    discord
  ];
}
