{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.btop = {
    enable = true;

    settings = {
      vim_keys = true;
      update_ms = 1000;
      log_level = "DISABLED";

      proc_tree = true;
      proc_gradient = false;

      disks_filter = "exclude=/var/log /var/cache /var/tmp /home /srv /";

      mem_graphs = true;
      swap_disk = false;
    };
  };
}
