{ ... }:

# configure spotify-player.
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
}
