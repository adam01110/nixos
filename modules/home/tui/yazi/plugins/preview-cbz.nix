{pkgs, ...}: {
  # Register the preview-cbz plugin source.
  programs.yazi.plugins.preview-cbz = pkgs.nur.repos.adam0.yaziPlugins.preview-cbz;

  programs.yazi.settings.plugin = {
    # Previewers that render content for preview-cbz.
    prepend_previewers = [
      {
        url = "*.cb{z,r}";
        run = "preview-cbz";
      }
    ];

    # Preloaders that render content for preview-cbz.
    prepend_preloaders = [
      {
        url = "*.cb{z,r}";
        run = "preview-cbz";
      }
    ];
  };
}
