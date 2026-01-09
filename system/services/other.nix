{...}:
# enable miscellaneous desktop services in one place.
{
  services = {
    # tune kernel bpf-related defaults for better performance.
    bpftune.enable = true;

    # flatpak runtime and portal integration for desktop apps.
    flatpak.enable = true;

    # fuse envfs to provide fhs-style paths under /bin.
    envfs.enable = true;

    # input stack defaults (touchpad, mouse) via libinput.
    libinput.enable = true;

    # system power profile switching (balanced, power-saver, performance).
    power-profiles-daemon.enable = true;

    # power and battery information service used by desktops.
    upower.enable = true;
  };
}
