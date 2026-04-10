{
  # keep-sorted start
  config,
  lib,
  # keep-sorted end
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
        # keep-sorted start
        audio_cache = true;
        normalization = true;
        # keep-sorted end
      };

      # Use better nerd font icons.
      # keep-sorted start
      liked_icon = "";
      pause_icon = "";
      play_icon = "";
      # keep-sorted end
    };
  };

  # Create desktop entry to allow launching via launcher.
  xdg.desktopEntries.spotify-player = {
    name = "Spotify Player";
    genericName = "Music Player";
    icon = "spotify";

    exec = let
      # keep-sorted start
      spotify-player = getExe config.programs.spotify-player.package;
      terminalCommand = getExe config.xdg.terminal-exec.package;
      # keep-sorted end
    in "${terminalCommand} --title=Spotify-player ${spotify-player}";

    categories = [
      # keep-sorted start
      "Audio"
      "AudioVideo"
      "ConsoleOnly"
      "Music"
      "Player"
      # keep-sorted end
    ];
  };
}
