{pkgs, ...}:
# Configure hyprland plugins.
let
  inherit (builtins) attrValues;
in {
  wayland.windowManager.hyprland = {
    # Add hyprfocus, hyprsplit, and hypr-kinetic-scroll plugins.
    plugins = attrValues {
      inherit
        (pkgs.hyprlandPlugins)
        hyprfocus
        hyprsplit
        ;
    };

    settings.plugin = {
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
