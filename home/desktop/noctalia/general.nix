{ ... }:

# noctalia shell visuals and behavior.
{
  programs.noctalia-shell.settings.general =
    let
      radius = 0.30;
    in
    {
      animationSpeed = 2;
      compactLockScreen = false;
      dimmerOpacity = 0;
      enableShadows = true;
      forceBlackScreenCorners = false;
      iRadiusRatio = radius;
      lockOnSuspend = true;
      radiusRatio = radius;
      scaleRatio = 0.8;
      screenRadiusRatio = 0.5;
      shadowDirection = "center";
      shadowOffsetX = 0;
      shadowOffsetY = 0;
      showScreenCorners = true;
    };
}
