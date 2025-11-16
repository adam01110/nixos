{ ... }:

{
  # enable miscellaneous desktop services in one place.
  services = {
    # bluetooth applet and helpers (tray bluetooth manager).
    blueman.enable = true;

    # tune kernel bpf-related defaults for better performance.
    bpftune.enable = true;

    # flatpak runtime and portal integration for desktop apps.
    flatpak.enable = true;

    # periodic trim for ssds to maintain performance and longevity.
    fstrim.enable = true;

    # gio/gvfs backends: trash, smb/mtp/afc, network mounts, etc.
    gvfs.enable = true;

    # input stack defaults (touchpad, mouse) via libinput.
    libinput.enable = true;

    # system power profile switching (balanced, power-saver, performance).
    power-profiles-daemon.enable = true;

    # power and battery information service used by desktops.
    upower.enable = true;
  };
}
