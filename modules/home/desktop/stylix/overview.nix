{osConfig, ...}:
# Stylix colors for overzicht.
let
  inherit (builtins) mapAttrs;

  colors = mapAttrs (_: value: "#${value}") osConfig.lib.stylix.colors;
in {
  # Feed the shell palette through its module options.
  programs.overzicht.colors = with colors; {
    m3primary = base08;
    m3onPrimary = base00;
    m3primaryContainer = base01;
    m3onPrimaryContainer = base06;
    m3onSecondary = base00;
    m3secondaryContainer = base01;
    m3onSecondaryContainer = base06;
    m3onBackground = base05;
    m3surface = base00;
    m3surfaceContainerHigh = base01;
    m3surfaceContainerHighest = base02;
    m3surfaceVariant = base02;
    m3background = base01;
    m3secondary = base0B;
    m3surfaceContainerLow = base00;
    m3surfaceContainer = base0B;
    m3onSurface = base00;
    m3onSurfaceVariant = base06;
    m3inverseSurface = base02;
    m3inverseOnSurface = base06;
    m3outline = base06;
    m3outlineVariant = base03;
    m3shadow = base00;
  };
}
