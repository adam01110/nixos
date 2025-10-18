{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot = {
    extraModprobeConfig = ''
      options snd_hda_intel power_save=0

      blacklist iTCO_wdt
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
      "kernel.printk" = [
        3
        3
        3
        3
      ];
      "kernel.kptr_restrict" = 2;

      "kernel.kexec_load_disabled" = 1;
      "net.core.netdev_max_backlog" = 4096;
      "fs.file-max" = 2097152;
    };
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="sound", KERNEL=="card*", DRIVERS=="snd_hda_intel", TEST!="/run/udev/snd-hda-intel-powersave", \
        RUN+="/usr/bin/bash -c 'touch /run/udev/snd-hda-intel-powersave; \
            [[ $$(cat /sys/class/power_supply/BAT0/status 2>/dev/null) != \"Discharging\" ]] && \
            echo $$(cat /sys/module/snd_hda_intel/parameters/power_save) > /run/udev/snd-hda-intel-powersave && \
            echo 0 > /sys/module/snd_hda_intel/parameters/power_save'"

    SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="0", TEST=="/sys/module/snd_hda_intel", \
        RUN+="/usr/bin/bash -c 'echo $$(cat /run/udev/snd-hda-intel-powersave 2>/dev/null || \
            echo 10) > /sys/module/snd_hda_intel/parameters/power_save'"

    SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", TEST=="/sys/module/snd_hda_intel", \
        RUN+="/usr/bin/bash -c '[[ $$(cat /sys/module/snd_hda_intel/parameters/power_save) != 0 ]] && \
            echo $$(cat /sys/module/snd_hda_intel/parameters/power_save) > /run/udev/snd-hda-intel-powersave; \
            echo 0 > /sys/module/snd_hda_intel/parameters/power_save'"

    ACTION=="change", KERNEL=="zram0", ATTR{initstate}=="1", SYSCTL{vm.swappiness}="150", \
      RUN+="/bin/sh -c 'echo N > /sys/module/zswap/parameters/enabled'"

    KERNEL=="rtc0", GROUP="audio"
    KERNEL=="hpet", GROUP="audio"

    ACTION=="add", SUBSYSTEM=="scsi_host", KERNEL=="host*", \
        ATTR{link_power_management_policy}=="*", \
        ATTR{link_power_management_policy}="max_performance"

    ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", \
      ATTR{queue/scheduler}="bfq"

    ACTION=="add|change", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/rotational}=="0", \
      ATTR{queue/scheduler}="mq-deadline"

    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", \
      ATTR{queue/scheduler}="none"

    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", \
      ATTRS{id/bus}=="ata", RUN+="/usr/bin/hdparm -B 254 -S 0 /dev/%k"

    DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"
  '';

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

    extraConfig = ''
      [Manager]
      DefaultLimitNOFILE=2048:2097152
      DefaultTimeoutStartSec=15s
      DefaultTimeoutStopSec=10s
    '';
  };
}
