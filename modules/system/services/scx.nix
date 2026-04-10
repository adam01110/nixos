{
  # keep-sorted start
  config,
  lib,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit
    (lib)
    # keep-sorted start
    mkEnableOption
    mkIf
    # keep-sorted end
    ;

  cfgScx = config.optServices.scx;
in {
  options.optServices.scx.enable = mkEnableOption "Enable the scx sched-ext service.";

  config.services.scx = mkIf cfgScx.enable {
    enable = true;

    # Use the rust scheds package with lavd and autopower tuning.
    package = pkgs.scx.rustscheds;
    scheduler = "scx_lavd";

    extraArgs = ["--autopower"];
  };
}
