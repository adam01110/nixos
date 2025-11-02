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
    activeBorder = rgb colors.base03;
    activeGroupBorder = rgb colors.base03;
    activeGroupBarBorder = rgb colors.base03;
    hyprexpoBackground = rgb colors.base03;
  };
}
