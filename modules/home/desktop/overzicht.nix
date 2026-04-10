_:
# Enable overzicht and run it as a user service.
{
  programs.overzicht = {
    enable = true;
    systemd.enable = true;

    # Blend Overzicht's built-in panel shadow with a light fullscreen dim backdrop.
    settings.effects = {
      enableBackdrop = true;

      # keep-sorted start
      backdropOpacity = 0.18;
      emptyWorkspaceWallpaperOverlayOpacity = 0.12;
      panelOpacity = 0.93;
      windowOverlayOpacity = 0.06;
      workspaceOpacity = 1;
      # keep-sorted end
    };
  };
}
