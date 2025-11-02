{
  lib,
  osConfig,
  ...
}:

let
  sansSerifFont = osConfig.stylix.fonts.sansSerif.name;
  monospaceFont = osConfig.stylix.fonts.monospace.name;

  stylixColors = osConfig.lib.stylix.colors;
  hashPrefix =
    value: if lib.isString value && !(lib.strings.hasPrefix "#" value) then "#${value}" else value;
  colors = builtins.mapAttrs (_: hashPrefix) stylixColors;
in
{
  _module.args.noctaliaStylix.fonts = {
    default = sansSerifFont;
    fixed = monospaceFont;
  };

  home.file.".config/noctalia/colors.json".text = builtins.toJSON {
    mError = colors.base08;
    mOnError = colors.base00;
    mOnPrimary = colors.base00;
    mOnSecondary = colors.base00;
    mOnSurface = colors.base06;
    mOnSurfaceVariant = colors.base05;
    mOnTertiary = colors.base00;
    mOutline = colors.base03;
    mPrimary = colors.base0B;
    mSecondary = colors.base0A;
    mShadow = colors.base00;
    mSurface = colors.base00;
    mSurfaceVariant = colors.base01;
    mTertiary = colors.base0B;
  };
}
