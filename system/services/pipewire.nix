{...}:
# pipewire with wireplumber and legacy audio shims.
{
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    # keep 32-bit audio working for legacy apps and games.
    alsa.support32Bit = true;
  };
}
