{
  osConfig,
  ...
}:

# helpers for mapping stylix fonts and colors to noctalia.
let
  inherit (builtins)
    mapAttrs
    toJSON
    ;

  sansSerifFont = osConfig.stylix.fonts.sansSerif.name;
  monospaceFont = osConfig.stylix.fonts.monospace.name;

  colors = mapAttrs (_: value: "#${value}") osConfig.lib.stylix.colors;
in
{
  # expose default and fixed font names for noctalia ui.
  _module.args.noctaliaStylix.fonts = {
    default = sansSerifFont;
    fixed = monospaceFont;
  };

  # write the noctalia color palette to a json file.
  xdg.configFile."noctalia/colors.json".text =
    with colors;
    toJSON {
      mError = base08;
      mHover = base0D;
      mOnHover = base00;
      mOnError = base00;
      mOnPrimary = base00;
      mOnSecondary = base00;
      mOnSurface = base06;
      mOnSurfaceVariant = base05;
      mOnTertiary = base00;
      mOutline = base03;
      mPrimary = base0B;
      mSecondary = base0A;
      mShadow = base00;
      mSurface = base00;
      mSurfaceVariant = base01;
      mTertiary = base0D;
    };
}
