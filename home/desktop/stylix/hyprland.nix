{
  osConfig,
  lib,
  ...
}:

# stylix color overrides for hyprland integration.
let
  inherit (lib) mkForce;

  colors = osConfig.lib.stylix.colors;
  # convert base16 hex into hyprland-friendly rgb string.
  rgb = color: "rgb(${color})";
in
{
  # set the active border color used by hyprland decorations.
  wayland.windowManager.hyprland.settings.general."col.active_border" = mkForce (rgb colors.base03);
}
