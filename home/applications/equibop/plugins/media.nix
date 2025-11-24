{
  cfgCamera,
  ...
}:

# plugins for media, calls, and voice features.
{
  allCallTimers.enabled = true;
  biggerStreamPreview.enabled = true;
  callTimer.enabled = true;
  disableCameras.enabled = !cfgCamera;
  disableCallIdle.enabled = true;
  musicControls = {
    enabled = true;
    LyricsConversion = "Romanized";
    showYoutubeMusicControls = true;
  };
  pictureInPicture.enabled = true;
  vcPanelSettings = {
    enabled = true;
    camera = cfgCamera;
    showOutputDeviceHeader = true;
    showInputDeviceHeader = true;
    showVideoDeviceHeader = true;
  };
  videoSpeed.enabled = true;
  voiceButtons = {
    enabled = true;
    whichNameToShow = "username";
  };
  voiceChatDoubleClick.enabled = true;
  voiceDownload.enabled = true;
  voiceMessages.enabled = true;
  volumeBooster.enabled = true;
}
