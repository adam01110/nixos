{
  osConfig,
  ...
}:

let
  colors = osConfig.lib.stylix.colors;
  rgb = color: "rgb(${color})";
in
{
  _module.args.hyprlandStylix = {
    inactiveBorder = rgb colors.base03;
    activeGroupBorder = rgb colors.base03;
    hyprexpoBackground = rgb colors.base03;
  };
}
