{pkgs, ...}: {
  # Register the spot-audio plugin source.
  programs.yazi.plugins.spot-audio = pkgs.nur.repos.adam0.yaziPlugins.spot-audio;

  # Spotters that render content for spot-audio.
  programs.yazi.settings.plugin.append_spotters = [
    # keep-sorted start block=yes newline_separated=yes
    {
      mime = "audio/mpegurl";
      run = "code";
    }

    {
      url = "audio/*";
      run = "spot-audio";
    }
    # keep-sorted end
  ];
}
