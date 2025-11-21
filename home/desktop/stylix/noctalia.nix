{
  osConfig,
  pkgs,
  ...
}:

# stylix theme for noctalia-shell.
let
  inherit (builtins) mapAttrs;
  jsonFormat = pkgs.formats.json { };

  sansSerifFont = osConfig.stylix.fonts.sansSerif.name;
  monospaceFont = osConfig.stylix.fonts.monospace.name;

  colors = mapAttrs (_: value: "#${value}") osConfig.lib.stylix.colors;
in
{
  _module.args.noctaliaStylix = {
    # default and fixed font names.
    fonts = {
      default = sansSerifFont;
      fixed = monospaceFont;
    };

    # system monitor colors from the Stylix palette.
    systemMonitor = with colors; {
      warningColor = base0A;
      criticalColor = base08;
    };
  };

  # write the noctalia color palette to a json file.
  xdg.configFile."noctalia/colors.json".source =
    with colors;
    jsonFormat.generate "noctalia-theme.json" {
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
