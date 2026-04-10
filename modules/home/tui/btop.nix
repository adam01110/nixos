{
  # keep-sorted start
  config,
  lib,
  pkgs,
  # keep-sorted end
  ...
}:
# Configure btop.
let
  inherit (lib) mkOption types;

  inherit (config.btop) gpuBackends;
  hasCuda = lib.elem "cuda" gpuBackends;
  hasRocm = lib.elem "rocm" gpuBackends;

  # Pick gpu-aware version of btop.
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
        # keep-sorted start
        "cuda"
        "rocm"
        # keep-sorted end
      ]
    );
    default = [];
    description = "Select GPU backends to enable in btop.";
  };

  config.programs.btop = {
    enable = true;
    package = btopPackage;

    settings = {
      # keep-sorted start newline_separated=yes
      # Disk filtering excludes system directories to focus on relevant storage.
      disks_filter = "exclude=/var/log /var/cache /var/tmp /home /srv /nix";

      # Disable logging
      log_level = "DISABLED";

      # Disable rounded corners for consistent flat design.
      rounded_corners = false;

      # Update frequency of 1000ms balances responsiveness and performance.
      update_ms = 1000;

      # Vim keys enable keyboard navigation similar to vim editor.
      vim_keys = true;
      # keep-sorted end

      # Process display settings.
      # keep-sorted start
      proc_aggregate = true;
      proc_gradient = false;
      proc_tree = true;
      # keep-sorted end

      # Memory display settings.
      # keep-sorted start
      mem_graphs = true;
      swap_disk = false;
      # keep-sorted end
    };
  };
}
