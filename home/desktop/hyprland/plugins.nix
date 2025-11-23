{ ... }:

# configure hyprland plugins.
{
  wayland.windowManager.hyprland.settings = {
    plugin = {
      # split plugin workspace count.
      hyprsplit.num_workspaces = 8;

      # hyprfocus bounce mode and intensity.
      hyprfocus = {
        mode = "bounce";
        bounce_strength = 0.995;
      };
    };
  };
}
