{
  config,
  lib,
  ...
}:
# logind configuration for power-related login manager settings.
let
  inherit
    (lib)
    mkEnableOption
    mkIf
    ;
in {
  options.optServices.logind.lidSwitch = mkEnableOption "Configure lid switch behavior.";

  # lid switch behavior: suspend on close, ignore when docked.
  config.services.logind.settings.Login = mkIf config.optServices.logind.lidSwitch {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";
  };
}
