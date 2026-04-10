{pkgs, ...}: {
  programs.yazi = {
    # keep-sorted start block=yes newline_separated=yes
    # Register the spot-cbz plugin source.
    plugins.spot-cbz = pkgs.nur.repos.adam0.yaziPlugins.spot-cbz;

    # Spotters that render content for spot-cbz.
    settings.plugin.append_spotters = [
      {
        url = "*.cb{z,r}";
        run = "spot-cbz";
      }
    ];
    # keep-sorted end
  };
}
