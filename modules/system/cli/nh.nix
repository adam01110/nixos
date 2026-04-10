{
  # keep-sorted start
  config,
  lib,
  vars,
  # keep-sorted end
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

    # keep-sorted start block=yes newline_separated=yes
    # Enable automatic cleaning.
    clean = mkIf cfgNh.autoClean.enable {
      enable = true;
      extraArgs = "--keep-since 2d --keep 4";
    };

    # Set flake root.
    flake = "/home/${username}/Nixos";
    # keep-sorted end
  };
}
