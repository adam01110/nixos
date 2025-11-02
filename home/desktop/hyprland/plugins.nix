{
  config,
  lib,
  ...
}:

let
  inherit (lib) mkIf;
in
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

    hyprexpo-gesture = mkIf (config.hyprland.overview == "hyprexpo") [ "3, vertical, expo" ];
  };
}
