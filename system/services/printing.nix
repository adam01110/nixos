{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfgPrinting = config.optServices.printing.enable;
in
{
  options.optServices.printing.enable = mkEnableOption "Enable printing services.";

  config = mkIf cfgPrinting {
    services.printing = {
      enable = true;
      openFirewall = true;
    };
  };
}
