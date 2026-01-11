{...}:
# noctalia shell visuals and behavior configuration.
{
  programs.noctalia-shell.settings.general = let
    # use sharp corners (no rounding) for consistent design.
    radius = 0;
  in {
    animationSpeed = 2;
    dimmerOpacity = 0;
    iRadiusRatio = radius;
    lockOnSuspend = true;
    radiusRatio = radius;
    scaleRatio = 0.8;
    shadowDirection = "center";
    shadowOffsetX = 0;
    shadowOffsetY = 0;
  };
}
