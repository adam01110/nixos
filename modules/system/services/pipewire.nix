_:
# Pipewire with wireplumber and legacy audio shims.
{
  services.pipewire = {
    enable = true;
    # keep-sorted start
    alsa.enable = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # keep-sorted end
    # Keep 32-bit audio working for legacy apps and games.
    alsa.support32Bit = true;
  };
}
