{
  config,
  lib,
  pkgs,
  ...
}:
# Sched-ext scx userspace scheduler service.
let
  inherit
    (lib)
    mkEnableOption
    mkIf
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
