{pkgs, ...}: {
  programs.yazi = {
    # keep-sorted start block=yes newline_separated=yes
    # Register the preview-epub plugin source.
    plugins.preview-epub = pkgs.nur.repos.adam0.yaziPlugins.preview-epub;

    settings.plugin = {
      # keep-sorted start block=yes newline_separated=yes
      # Preloaders that render content for preview-epub.
      prepend_preloaders = [
        {
          mime = "";
          run = "preview-epub";
        }
      ];

      # Previewers that render content for preview-epub.
      prepend_previewers = [
        {
          mime = "";
          run = "preview-epub";
        }
      ];
      # keep-sorted end
    };
    # keep-sorted end
  };
}
