{
  # keep-sorted start
  config,
  lib,
  # keep-sorted end
  ...
}:
# Tlp power management service with power saving features.
let
  inherit
    (lib)
    # keep-sorted start
    mkEnableOption
    mkForce
    mkIf
    # keep-sorted end
    ;

  cfgTlp = config.optServices.tlp.enable;
in {
  options.optServices.tlp.enable = mkEnableOption "Enable TLP power management.";

  config.services = mkIf cfgTlp {
    tlp = {
      enable = true;

      # Enable tlp power daemon for power-profiles-daemon compatibility.
      pd.enable = true;
    };

    # Disable conflicting power management daemon.
    power-profiles-daemon.enable = mkForce false;
  };
}
