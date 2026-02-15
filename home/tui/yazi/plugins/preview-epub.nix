{pkgs, ...}: {
  # Register the preview-epub plugin source.
  programs.yazi.plugins.preview-epub = pkgs.nur.repos.adam0.yaziPlugins.preview-epub;

  programs.yazi.settings.plugin = {
    # Previewers that render content for preview-epub.
    prepend_previewers = [
      {
        mime = "";
        run = "preview-epub";
      }
    ];

    # Preloaders that render content for preview-epub.
    prepend_preloaders = [
      {
        mime = "";
        run = "preview-epub";
      }
    ];
  };
}
