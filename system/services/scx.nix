{
  config,
  lib,
  pkgs,
  ...
}:
# sched-ext scx userspace scheduler service.
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

    package = pkgs.scx.rustscheds;
    scheduler = "scx_lavd";

    extraArgs = ["--autopower"];
  };
}
