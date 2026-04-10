{pkgs, ...}:
# Configure hyprland plugins.
let
  inherit (builtins) attrValues;
in {
  wayland.windowManager.hyprland = {
    # keep-sorted start block=yes newline_separated=yes
    # Add hyprfocus, hyprsplit, and hypr-kinetic-scroll plugins.
    plugins = attrValues {
      inherit
        (pkgs.hyprlandPlugins)
        # keep-sorted start
        hyprfocus
        hyprsplit
        # keep-sorted end
        ;
    };

    settings.plugin = {
      # keep-sorted start block=yes newline_separated=yes
      # Hyprfocus bounce mode and intensity.
      hyprfocus = {
        # keep-sorted start
        bounce_strength = 0.995;
        mode = "bounce";
        # keep-sorted end
      };

      # Split plugin workspace count.
      hyprsplit.num_workspaces = 8;
      # keep-sorted ends
    };
    # keep-sorted end
  };
}
