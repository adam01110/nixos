{pkgs, ...}:
# System-wide hyprland setup using packages from the hyprland flake.
{
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    # Remove uuctl support from uwsm.
    uwsm.package = pkgs.uwsm.override {uuctlSupport = false;};
  };
}
