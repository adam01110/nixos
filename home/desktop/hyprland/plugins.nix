{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    plugin = {
      hyprsplit.num_workspaces = 8;

      hyprfocus = {
        mode = "bounce";
        bounce_strength = 0.98;
      };
    };
  };
}
