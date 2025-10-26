{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf;

  cfgOverview = config.hyprland.overview;
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

    hyprexpo-gesture = mkIf (cfgOverview == "hyprexpo") [ "3, vertical, expo" ];
  };
}
