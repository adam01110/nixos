{
  config,
  lib,
  ...
}:
# tlp power management service with power saving features.
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

      # enable tlp power daemon for power-profiles-daemon compatibility.
      # tlp-pd.enable = true;
    };

    # disable conflicting power management daemon.
    power-profiles-daemon.enable = mkForce false;
  };
}
