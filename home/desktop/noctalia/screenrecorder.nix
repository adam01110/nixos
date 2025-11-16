{
  config,
  ...
}:
let
  videosDir = config.xdg.userDirs.videos;
in
{
  # default recorder codecs and target directory.
  programs.noctalia-shell.settings.screenRecorder = {
    audioCodec = "opus";
    audioSource = "default_output";
    colorRange = "limited";
    directory = "${videosDir}/Recordings";
    frameRate = 60;
    quality = "very_high";
    showCursor = true;
    videoCodec = "hevc";
    videoSource = "portal";
  };
}
