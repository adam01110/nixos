_:
# Enable miscellaneous desktop services in one place.
{
  services = {
    # keep-sorted start newline_separated=yes
    # Auto-tune kernel bpf settings for performance.
    bpftune.enable = true;

    # Provide fhs-style paths for compatibility with legacy applications.
    envfs.enable = true;

    # Flatpak runtime and portal integration for desktop apps.
    flatpak.enable = true;

    # Enable gnome evolution data server for calendar and contact integration.
    gnome.evolution-data-server.enable = true;

    # Input stack defaults (touchpad, mouse) via libinput.
    libinput.enable = true;

    # System power profile switching (balanced, power-saver, performance).
    power-profiles-daemon.enable = true;

    # Disk management dbus service.
    udisks2.enable = true;

    # Power and battery information service used by desktops.
    upower.enable = true;
    # keep-sorted end
  };
}
