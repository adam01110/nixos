{config, ...}:
# Plugins for media, calls, and voice features.
let
  cfgCamera = config.equibop.camera.enable;
in {
  programs.nixcord.config.plugins = {
    # keep-sorted start block=yes
    AllCallTimers.enable = true;
    BiggerStreamPreview.enable = true;
    CallTimer.enable = true;
    DisableCallIdle.enable = true;
    DisableCameras.enable = !cfgCamera;
    MusicControls = {
      enable = true;
      # keep-sorted start
      showSpotifyControls = true;
      useSpotifyUris = true;
      # keep-sorted end
      LyricsConversion = "Romanized";
    };
    PictureInPicture.enable = true;
    VCPanelSettings = {
      enable = true;
      camera = cfgCamera;
      # keep-sorted start
      showInputDeviceHeader = true;
      showOutputDeviceHeader = true;
      showVideoDeviceHeader = true;
      # keep-sorted end
    };
    VideoSpeed.enable = true;
    VoiceButtons = {
      enable = true;
      whichNameToShow = "username";
      # keep-sorted start
      VoiceChatDoubleClick.enable = true;
      VoiceDownload.enable = true;
      VoiceMessages.enable = true;
      VolumeBooster.enable = true;
      # keep-sorted end
    };
    # keep-sorted end
  };
}
