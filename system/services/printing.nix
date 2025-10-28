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
  options.optServices.printing.enable = mkEnableOption "Enable printing services.";

  config =
    let
      cfgPrinting = config.optServices.printing.enable;
    in
    mkIf cfgPrinting {
      services.printing = {
        enable = true;
        openFirewall = true;
      };
    };
}
