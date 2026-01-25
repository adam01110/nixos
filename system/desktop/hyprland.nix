{pkgs, ...}:
# system-wide hyprland setup using packages from the hyprland flake.
{
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    uwsm.package = pkgs.uwsm.override {uuctlSupport = false;};
  };
}
