{pkgs, ...}: {
  # Register the spot-cbz plugin source.
  programs.yazi.plugins.spot-cbz = pkgs.nur.repos.adam0.yaziPlugins.spot-cbz;

  # Spotters that render content for spot-cbz.
  programs.yazi.settings.plugin.append_spotters = [
    {
      url = "*.cb{z,r}";
      run = "spot-cbz";
    }
  ];
}
