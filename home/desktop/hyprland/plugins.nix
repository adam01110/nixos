{
  config,
  lib,
  pkgs,
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    plugin = {
      hyprsplit.num_workspaces = 9;

      hyprfocus = {
        mode = "bounce";
        bounce_strength = 0.98;
      };

      hyprexpo.gap_size = 8;
    };
  };
}
