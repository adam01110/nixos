{
  osConfig,
  lib,
  ...
}:
# stylix theme for noctalia-shell.
let
  inherit (builtins) mapAttrs;
  inherit (lib) mkForce;

  colors = mapAttrs (_: value: "#${value}") osConfig.lib.stylix.colors;
in {
  programs.noctalia-shell = {
    # system monitor colors from stylix.
    settings = {
      bar = {
        backgroundOpacity = mkForce 1.0;
        capsuleOpacity = mkForce 1.0;
      };
      ui.panelBackgroundOpacity = mkForce 1.0;
      dock.backgroundOpacity = mkForce 1.0;
      osd.backgroundOpacity = mkForce 1.0;
      notifications.backgroundOpacity = mkForce 1.0;

      palette.systemMonitor = with colors; {
        useCustomColors = true;
        warningColor = base0A;
        criticalColor = base08;
      };
    };

    # write the noctalia color palette to a json file.
    colors = with colors; {
      mHover = mkForce base0D;
      mOnSurface = mkForce base06;
      mPrimary = mkForce base0B;
      mSecondary = mkForce base0A;
      mTertiary = mkForce base0D;
    };
  };
}
