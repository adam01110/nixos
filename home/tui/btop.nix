{
  config,
  lib,
  pkgs,
  ...
}:
# configure btop.
let
  inherit (lib) mkOption types;

  gpuBackends = config.btop.gpuBackends;
  hasCuda = lib.elem "cuda" gpuBackends;
  hasRocm = lib.elem "rocm" gpuBackends;

  # pick gpu-aware version of btop.
  btopPackage =
    if hasCuda && hasRocm
    then
      pkgs.btop.override {
        cudaSupport = true;
        rocmSupport = true;
      }
    else if hasCuda
    then pkgs.btop-cuda
    else if hasRocm
    then pkgs.btop-rocm
    else pkgs.btop;
in {
  options.btop.gpuBackends = mkOption {
    type = types.listOf (
      types.enum [
        "cuda"
        "rocm"
      ]
    );
    default = [];
    description = "Select GPU backends to enable in btop.";
  };

  config.programs.btop = {
    enable = true;
    package = btopPackage;

    settings = {
      vim_keys = true;
      update_ms = 1000;
      log_level = "DISABLED";

      proc_tree = true;
      proc_gradient = false;
      proc_aggregate = true;

      disks_filter = "exclude=/var/log /var/cache /var/tmp /home /srv /nix";

      mem_graphs = true;
      swap_disk = false;

      rounded_corners = false;
    };
  };
}
