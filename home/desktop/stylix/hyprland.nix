{
  osConfig,
  ...
}:

let
  colors = osConfig.lib.stylix.colors;
  rgb = color: "rgb(${color})";
in
{
  # set the active border color used by hyprland decorations.
  _module.args.hyprlandStylix.activeBorder = rgb colors.base03;
}
