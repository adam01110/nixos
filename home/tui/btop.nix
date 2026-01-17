{
  config,
  lib,
  pkgs,
  ...
}:
# configure btop.
let
  inherit (lib) mkOption types;

  inherit (config.btop) gpuBackends;
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
      # vim keys enable keyboard navigation similar to vim editor.
      vim_keys = true;

      # update frequency of 1000ms balances responsiveness and performance.
      update_ms = 1000;

      # disable logging
      log_level = "DISABLED";

      # process display settings.
      proc_tree = true;
      proc_gradient = false;
      proc_aggregate = true;

      # disk filtering excludes system directories to focus on relevant storage.
      disks_filter = "exclude=/var/log /var/cache /var/tmp /home /srv /nix";

      # memory display settings.
      mem_graphs = true;
      swap_disk = false;

      # disable rounded corners for consistent flat design.
      rounded_corners = false;
    };
  };
}
