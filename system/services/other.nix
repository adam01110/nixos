{...}:
# enable miscellaneous desktop services in one place.
{
  services = {
    # auto-tune kernel bpf settings for performance.
    bpftune.enable = true;

    # flatpak runtime and portal integration for desktop apps.
    flatpak.enable = true;

    # provide fhs-style paths for compatibility with legacy applications.
    envfs.enable = true;

    # input stack defaults (touchpad, mouse) via libinput.
    libinput.enable = true;

    # system power profile switching (balanced, power-saver, performance).
    power-profiles-daemon.enable = true;

    # power and battery information service used by desktops.
    upower.enable = true;

    # enable gnome evolution data server for calendar and contact integration.
    gnome.evolution-data-server.enable = true;
  };
}
