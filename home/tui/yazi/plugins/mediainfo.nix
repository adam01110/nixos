{pkgs, ...}: {
  # Register the mediainfo plugin source.
  programs.yazi.plugins.mediainfo = pkgs.yaziPlugins.mediainfo;

  # Use mediainfo for media and related mime types.
  programs.yazi.settings.plugin = {
    # Replace default magick/image/video previewers with mediainfo.
    prepend_previewers = [
      {
        mime = "{audio,video,image}/*";
        run = "mediainfo";
      }
      {
        mime = "application/subrip";
        run = "mediainfo";
      }
      # Cover adobe illustrator/postscript separately from image/adobe.photoshop.
      {
        mime = "application/postscript";
        run = "mediainfo";
      }
    ];

    # Replace default magick/image/video preloaders with mediainfo.
    prepend_preloaders = [
      {
        mime = "{audio,video,image}/*";
        run = "mediainfo";
      }
      {
        mime = "application/subrip";
        run = "mediainfo";
      }
      # Cover adobe illustrator/postscript separately from image/adobe.photoshop.
      {
        mime = "application/postscript";
        run = "mediainfo";
      }
    ];
  };
}
