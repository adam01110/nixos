{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkOption types;
in
{
  options.nvtop.types = mkOption {
    type = types.listOf (
      types.enum [
        "intel"
        "amd"
      ]
    );
    default = [ ];
    description = "Choose which GPU types to monitor with nvtop.";
  };

  config.home.packages =
    let
      cfgNvtop = config.nvtop.types;
    in
    map (t: pkgs.nvtopPackages.${t}) cfgNvtop;
}
