_:
# Enable overzicht and run it as a user service.
{
  programs.overzicht = {
    enable = true;
    systemd.enable = true;

    # Blend Overzicht's built-in panel shadow with a light fullscreen dim backdrop.
    settings.effects = {
      enableBackdrop = true;
      backdropOpacity = 0.18;
      panelOpacity = 0.93;
      workspaceOpacity = 1;
      emptyWorkspaceWallpaperOverlayOpacity = 0.12;
      windowOverlayOpacity = 0.06;
    };
  };
}
