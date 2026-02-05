{
  config,
  lib,
  ...
}:
# Configure spotify-player.
let
  inherit (lib) getExe;
in {
  programs.spotify-player = {
    enable = true;
    settings = {
      # Enable audio cache and normalization.
      device = {
        audio_cache = true;
        normalization = true;
      };

      # Use better nerd font icons.
      play_icon = "";
      pause_icon = "";
      liked_icon = "";
    };
  };

  # Create desktop entry to allow launching via launcher.
  xdg.desktopEntries.spotify-player = {
    name = "Spotify Player";
    genericName = "Music Player";
    icon = "spotify";
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
