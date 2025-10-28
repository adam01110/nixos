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
in
{
  options.optServices.fwupd.enable = mkEnableOption "Enable firmware update services.";

  config =
    let
      cfgFwupd = config.optServices.fwupd.enable;
    in
    mkIf cfgFwupd {
      services.fwupd.enable = true;
    };
}
