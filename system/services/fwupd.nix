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

  config = mkIf config.optServices.fwupd.enable {
    services.fwupd.enable = true;
  };
}
