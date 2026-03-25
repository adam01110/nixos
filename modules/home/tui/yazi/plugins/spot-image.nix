{pkgs, ...}: {
  # Register the spot-image plugin source.
  programs.yazi.plugins.spot-image = pkgs.nur.repos.adam0.yaziPlugins.spot-image;

  # Spotters that render content for spot-image.
  programs.yazi.settings.plugin.append_spotters = [
    {
      mime = "image/*";
      run = "spot-image";
    }
  ];
}
