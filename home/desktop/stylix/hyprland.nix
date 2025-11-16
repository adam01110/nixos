{
  osConfig,
  ...
}:

let
  colors = osConfig.lib.stylix.colors;
  rgb = color: "rgb(${color})";
in
{
  # stylix color plumbing for hyprland integration.
  # set the active border color used by hyprland decorations.
  _module.args.hyprlandStylix.activeBorder = rgb colors.base03;
}
