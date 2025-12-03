{
  osConfig,
  lib,
  ...
}:

# stylix color for hyprland integration.
let
  inherit (lib) mkForce;

  colors = osConfig.lib.stylix.colors;
  rgb = color: "rgb(${color})";
in
{
  # set the active border color used by hyprland decorations.
  wayland.windowManager.hyprland.settings.general."col.active_border" = mkForce (rgb colors.base03);
}
