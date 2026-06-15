{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.veloxos.services.zram;
in {
  options = {
    veloxos.services.zram = {
      enable = mkEnableOption "Optimiertes VeloxOS ZRAM-Swap für Gaming und Dev-Workloads";
    };
  };

  config = mkIf cfg.enable {
    # Offizielle NixOS ZRAM Option triggern
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 25; 
    };

    # Systemd OOM-Killer (schützt vor harten System-Freezes bei RAM-Mangel)
    systemd.oomd = {
      enable = true;
      enableUserSlices = true;
    };

    # Kernel-Optimierungen für aggressiveres, aber verlustfreies ZRAM-Swapping
    boot.kernel.sysctl = {
      "vm.swappiness" = 180; 
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 50;
      "vm.page-cluster" = 0;
    };
  };
}
