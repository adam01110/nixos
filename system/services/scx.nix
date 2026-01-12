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
    mkForce
    ;

  cfgScx = config.optServices.scx;
in {
  options.optServices.scx.enable = mkEnableOption "Enable the scx sched-ext service.";

  config = mkIf cfgScx.enable {
    services.scx = {
      enable = true;

      package = pkgs.scx.rustscheds;
      scheduler = "scx_lavd";

      extraArgs = ["--autopower"];
    };

    # use cachyos kernel with sched-ext support.
    boot.kernelPackages = mkForce pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;
  };
}
