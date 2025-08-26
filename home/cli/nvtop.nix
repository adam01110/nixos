{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.nvtop.types;
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

  config = {
    home.packages = map (t: pkgs.nvtopPackages.${t}) cfg;
  };
}
