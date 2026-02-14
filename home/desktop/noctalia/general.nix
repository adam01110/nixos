_:
# Noctalia shell visuals and behavior configuration.
{
  programs.noctalia-shell.settings.general = let
    # Use sharp corners (no rounding) for consistent design.
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
    telemetryEnabled = false;

    clockStyle = "analog";
    lockScreenAnimations = true;
    lockScreenBlur = 0.2;

    keybinds = {
      keyDown = [
        "Down"
        "Ctrl+J"
      ];
      keyLeft = [
        "Left"
        "Ctrl+H"
      ];
      keyRight = [
        "Right"
        "Ctrl+L"
      ];
      keyUp = [
        "Up"
        "Ctrl+K"
      ];
    };
  };
}
