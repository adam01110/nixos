{
  osConfig,
  ...
}:

let
  colors = osConfig.lib.stylix.colors;

  sansSerifFont = osConfig.stylix.fonts.sansSerif.name;
  monospaceFont = osConfig.stylix.fonts.monospace.name;
in
{
  _module.args.noctaliaStylix = {
    colors = {
      mError = colors.base08;
      mOnError = colors.base07;
      mOnPrimary = colors.base05;
      mOnSecondary = colors.base05;
      mOnSurface = colors.base05;
      mOnSurfaceVariant = colors.base04;
      mOnTertiary = colors.base05;
      mOutline = colors.base03;
      mPrimary = colors.base0D;
      mSecondary = colors.base0E;
      mShadow = colors.base00;
      mSurface = colors.base00;
      mSurfaceVariant = colors.base01;
      mTertiary = colors.base0B;
    };

    fonts = {
      default = sansSerifFont;
      fixed = monospaceFont;
    };
  };
}
