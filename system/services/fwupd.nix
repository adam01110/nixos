{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfgFwupd = config.optServices.fwupd.enable;
in
{
  options.optServices.fwupd.enable = mkEnableOption "Enable firmware update services.";

  config = mkIf cfgFwupd {
    services.fwupd.enable = true;
  };
}
