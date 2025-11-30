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
    # enable the printing service.
    services.printing = {
      enable = true;
      openFirewall = true;
    };

    # enable some fonts for ghostscript.
    fonts.enableGhostscriptFonts = true;
  };
}
