{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (builtins) attrValues;
  inherit
    (lib)
    getExe
    getExe'
    mkEnableOption
    optional
    ;
in {
  # optional rcu lazy toggle to defer callback processing.
  options.optTweaks.rcuLazy.enable = mkEnableOption "Enable RCU lazy mode.";

  config = {
    # assorted low-level tweaks and helper tools.
    environment.systemPackages = attrValues {
      inherit
        (pkgs)
        bash
        hdparm
        coreutils
        ;
    };

    # kernel parameters aimed at low latency desktops.
    boot = {
      extraModprobeConfig = ''
        options snd_hda_intel power_save=0

        blacklist iTCO_wdt
        blacklist wdat_wdt
      '';

      kernelModules.ntsync = true;

      kernel.sysctl = {
        "vm.swappiness" = 100;
        "vm.vfs_cache_pressure" = 50;
        "vm.dirty_bytes" = 268435456;
        "vm.page-cluster" = 0;
        "vm.dirty_background_bytes" = 67108864;
        "vm.dirty_writeback_centisecs" = 1500;
        "kernel.nmi_watchdog" = 0;
        "kernel.unprivileged_userns_clone" = 1;
        "kernel.printk" = "3 3 3 3";
        "kernel.kptr_restrict" = 2;
        "kernel.kexec_load_disabled" = 1;
        "net.core.netdev_max_backlog" = 4096;
        "fs.file-max" = 2097152;
        "net.ipv4.ip_forward" = 1;
        "net.ipv4.tcp_mtu_probing" = 1;
        "net.ipv4.tcp_tw_reuse" = 1;
        "kernel.sched_rt_runtime_us" = -1;
      };

      kernelParams =
        [
          "lru_gen=y"
        ]
        ++ optional config.optTweaks.rcuLazy.enable "rcutree.enable_rcu_lazy=1";
    };

    # udev rules for audio power saving and scheduler tuning.
    services.udev.extraRules = let
      bash = getExe pkgs.bash;
      hdparm = getExe pkgs.hdparm;

      cat = getExe' pkgs.coreutils "cat";
      echo = getExe' pkgs.coreutils "echo";
      touch = getExe' pkgs.coreutils "touch";
    in ''
      ACTION=="add", SUBSYSTEM=="sound", KERNEL=="card*", DRIVERS=="snd_hda_intel", TEST!="/run/udev/snd-hda-intel-powersave", \
          RUN+="${bash} -c '${touch} /run/udev/snd-hda-intel-powersave; \
              [[ $$((${cat} /sys/class/power_supply/BAT0/status 2>/dev/null) != \"Discharging\" ]] && \
              ${echo} $$((${cat} /sys/module/snd_hda_intel/parameters/power_save) > /run/udev/snd-hda-intel-powersave && \
              ${echo} 0 > /sys/module/snd_hda_intel/parameters/power_save'"

      SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="0", TEST=="/sys/module/snd_hda_intel", \
          RUN+="${bash} -c '${echo} $$((${cat} /run/udev/snd-hda-intel-powersave 2>/dev/null || \
              ${echo} 10) > /sys/module/snd_hda_intel/parameters/power_save'"

      SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", TEST=="/sys/module/snd_hda_intel", \
          RUN+="${bash} -c '[[ $$((${cat} /sys/module/snd_hda_intel/parameters/power_save) != 0 ]] && \
              ${echo} $$(${cat} /sys/module/snd_hda_intel/parameters/power_save) > /run/udev/snd-hda-intel-powersave; \
              ${echo} 0 > /sys/module/snd_hda_intel/parameters/power_save'"

      ACTION=="change", KERNEL=="zram0", ATTR{initstate}=="1", SYSCTL{vm.swappiness}="150", \
        RUN+="${bash} -c '${echo} N > /sys/module/zswap/parameters/enabled'"

      KERNEL=="rtc0", GROUP="audio"
      KERNEL=="hpet", GROUP="audio"

      ACTION=="add", SUBSYSTEM=="scsi_host", KERNEL=="host*", \
          ATTR{link_power_management_policy}=="*", \
          ATTR{link_power_management_policy}="max_performance"

      ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", \
        ATTR{queue/scheduler}="bfq"

      ACTION=="add|change", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/rotational}=="0", \
        ATTR{queue/scheduler}="adios"

      ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", \
        ATTR{queue/scheduler}="adios"

      ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", \
        ATTRS{id/bus}=="ata", RUN+="${hdparm} -B 254 -S 0 /dev/%k"

      DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"
    '';

    # systemd limits and tmpfiles overrides.
    systemd = {
      tmpfiles.rules = [
        "d /var/lib/systemd/coredump 0755 root root 3d"

        "w! /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none - - - - 409"
        "w! /sys/kernel/mm/transparent_hugepage/defrag - - - - defer+madvise"
      ];

      user.extraConfig = ''
        [Manager]
        DefaultLimitNOFILE=1024:1048576
      '';

      settings.Manager = {
        DefaultLimitNOFILE = "2048:2097152";
        DefaultTimeoutStartSec = "15s";
        DefaultTimeoutStopSec = "10s";
      };
    };
  };
}
