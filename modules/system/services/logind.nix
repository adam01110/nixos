{
  # keep-sorted start
  config,
  lib,
  # keep-sorted end
  ...
}:
# Logind configuration for power-related login manager settings.
let
  inherit
    (lib)
    # keep-sorted start
    mkEnableOption
    mkIf
    # keep-sorted end
    ;
in {
  options.optServices.logind.lidSwitch = mkEnableOption "Configure lid switch behavior.";

  # Lid switch behavior: suspend on close, ignore when docked.
  config.services.logind.settings.Login = mkIf config.optServices.logind.lidSwitch {
    # keep-sorted start
    HandleLidSwitch = "suspend";
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "suspend";
    # keep-sorted end
  };
}
