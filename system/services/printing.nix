{
  config,
  lib,
  ...
}:

# optional printing service, toggled per host.
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
