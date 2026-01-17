_: {
  # use faster-piper for markdown, archives, and compressed text previews.
  programs.yazi.settings.plugin = {
    # previewers routed through faster-piper.
    prepend_previewers = [
      {
        url = "*.md";
        run = "faster-piper --rely-on-preloader";
      }
      {
        url = "*.tar*";
        run = "faster-piper --rely-on-preloader --format=url";
      }
      {
        url = "*.txt.gz";
        run = "faster-piper --rely-on-preloader";
      }
    ];

    # preloaders that render content for faster-piper.
    prepend_preloaders = [
      {
        url = "*.md";
        run = "faster-piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dracula -- '$1'";
      }
      {
        url = "*.tar*";
        run = "faster-piper -- tar tf '$1'";
      }
      {
        url = "*.txt.gz";
        run = "faster-piper -- gzip -dc '$1'";
      }
    ];
  };
}
