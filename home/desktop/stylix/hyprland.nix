{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkForce
    mkIf
    mkMerge
    ;

  cfgOverview = config.hyprland.overview;

  colors = osConfig.lib.stylix.colors;
  rgb = color: "rgb(${color})";
in
{
  wayland.windowManager.hyprland.settings = mkMerge [
    {
      general."col.inactive_border" = mkForce (rgb colors.base03);
      group."col.border_active" = mkForce (rgb colors.base03);
    }
    (mkIf (cfgOverview == "hyprexpo") { plugin.hyprexpo.bg_col = rgb colors.base03; })
  ];
}
