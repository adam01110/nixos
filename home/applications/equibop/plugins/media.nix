{
  cfgCamera,
  ...
}:

{
  AllCallTimers.enabled = true;
  BiggerStreamPreview.enabled = true;
  CallTimer.enabled = true;
  DisableCameras.enabled = !cfgCamera;
  DisableCallIdle.enabled = true;
  MusicControls = {
    enabled = true;
    LyricsConversion = "Romanized";
    showYoutubeMusicControls = true;
  };
  PictureInPicture.enabled = true;
  VCPanelSettings = {
    enabled = true;
    camera = cfgCamera;
    showOutputDeviceHeader = true;
    showInputDeviceHeader = true;
    showVideoDeviceHeader = true;
  };
  VideoSpeed.enabled = true;
  VoiceButtons = {
    enabled = true;
    whichNameToShow = "username";
  };
  VoiceChatDoubleClick.enabled = true;
  VoiceDownload.enabled = true;
  VoiceMessages.enabled = true;
  VolumeBooster.enabled = true;
}
