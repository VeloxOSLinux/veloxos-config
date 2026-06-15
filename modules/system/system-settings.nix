{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.veloxos.system;
in {
  # --- 1. Optionen für den Nutzer ---
  options.veloxos.system = {
    bootloader = {
      systemd-boot = mkOption {
        type = types.bool;
        default = true;
        description = "Aktiviert systemd-boot als Standard-Bootloader.";
      };
    };
    
    printing = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Aktiviert den CUPS-Druckdienst.";
      };
    };
  };

  # --- 2. Feste System-Infrastruktur & Gaming-Tweaks ---
  config = {
    # Bootloader (Bedingt durch die Option)
    boot.loader.systemd-boot.enable = cfg.bootloader.systemd-boot;
    boot.loader.efi.canTouchEfiVariables = cfg.bootloader.systemd-boot;

    # Performance & Gaming Kernel (Zen-Kernel)
    boot.kernelPackages = pkgs.linuxPackages_zen;

    # System-Optimierungen für Gaming und SSDs
    boot.kernel.sysctl = {
      "fs.file-max" = 2097152;
      "fs.inotify.max_user_watches" = 524288;
    };
    
    services.fstrim.enable = true;

    # Netzwerk & Kommunikation Basis
    networking.networkmanager.enable = true;
    services.dbus.enable = true;

    # Drucken (Bedingt durch die Option)
    services.printing.enable = cfg.printing.enable;

    # Unfreie Software erlauben (Wichtig für Steam/Nvidia)
    nixpkgs.config.allowUnfree = true;
  };
}
