{
  config,
  lib,
  ...
}:

# configure spotify-player.
let
  inherit (lib) getExe;
in
{
  programs.spotify-player = {
    enable = true;

    settings = {
      # enable audio cache and normalization.
      device = {
        audio_cache = true;
        normalization = true;
      };

      # use better nerd font icons.
      play_icon = "";
      pause_icon = "";
      liked_icon = "";

      # make panel edges rounded.
      border_type = "Rounded";
    };
  };

  # create desktop entry to allow launching via launcher.
  xdg.desktopEntries.spotify-player = {
    name = "Spotify player";
    genericName = "Music Player";
    exec = getExe config.programs.spotify-player.package;
    terminal = true;
    categories = [
      "Audio"
      "Music"
      "Player"
      "AudioVideo"
    ];
  };
}
