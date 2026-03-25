{
  config,
  lib,
  ...
}:
# Tlp power management service with power saving features.
let
  inherit
    (lib)
    mkEnableOption
    mkIf
    mkForce
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
