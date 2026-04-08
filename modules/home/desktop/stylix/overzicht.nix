{osConfig, ...}:
# Stylix colors for overzicht.
let
  inherit (builtins) mapAttrs;

  colors = mapAttrs (_: value: "#${value}") osConfig.lib.stylix.colors;
  sansSerifFont = osConfig.stylix.fonts.sansSerif.name;
in {
  # Feed the shell palette through its module options.
  programs.overzicht = {
    settings.appearance.font.family = {
      main = sansSerifFont;
      title = sansSerifFont;
      expressive = sansSerifFont;
    };

    colors = with colors; {
      primary = base08;
      onPrimary = base00;
      primaryContainer = base01;
      onPrimaryContainer = base06;
      onSecondary = base00;
      secondaryContainer = base01;
      onSecondaryContainer = base06;
      onBackground = base05;
      surface = base00;
      surfaceContainerHigh = base01;
      surfaceContainerHighest = base02;
      surfaceVariant = base02;
      background = base01;
      secondary = base0B;
      surfaceContainerLow = base00;
      surfaceContainer = base0B;
      onSurface = base00;
      onSurfaceVariant = base07;
      inverseSurface = base02;
      inverseOnSurface = base06;
      outline = base06;
      outlineVariant = base03;
      shadow = base00;
    };
  };
}
