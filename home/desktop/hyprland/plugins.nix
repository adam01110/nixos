_:
# Configure hyprland plugins.
{
  wayland.windowManager.hyprland.settings = {
    plugin = {
      # Split plugin workspace count.
      hyprsplit.num_workspaces = 8;

      # Hyprfocus bounce mode and intensity.
      hyprfocus = {
        mode = "bounce";
        bounce_strength = 0.995;
      };
    };
  };
}
