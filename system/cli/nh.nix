{
  config,
  lib,
  vars,
  ...
}:
# Configure nh.
let
  inherit (lib) mkEnableOption mkIf;
  inherit (vars) username;

  cfgNh = config.optServices.nh;
in {
  options.optServices.nh.autoClean.enable = mkEnableOption "Enable nh automatic cleaning.";

  config.programs.nh = {
    enable = true;

    # Set flake root.
    flake = "/home/${username}/Nixos";

    # Enable automatic cleaning.
    clean = mkIf cfgNh.autoClean.enable {
      enable = true;
      extraArgs = "--keep-since 2d --keep 4";
    };
  };
}
