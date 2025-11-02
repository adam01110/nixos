{
  config,
  lib,
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

  config = mkIf config.optServices.printing.enable {
    services.printing = {
      enable = true;
      openFirewall = true;
    };
  };
}
