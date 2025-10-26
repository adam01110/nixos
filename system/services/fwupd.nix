{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfgFwupd = config.optServices.fwupd.enable;
in
{
  options.optServices.fwupd.enable = mkEnableOption "Enable firmware update services.";

  config = mkIf cfgFwupd {
    services.fwupd.enable = true;
  };
}
