{
  config,
  lib,
  pkgs,
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    plugin = {
      split-monitor-workspaces = {
        count = 5;
        keep_focused = 1;
        enable_wrapping = 0;
      };

      hyprfocus = {
        mode = "bounce";
        bounce_strength = 0.98;
      };
    };
  };
}
