_: {
  # use mediainfo for media and related mime types.
  programs.yazi.settings.plugin = {
    # replace default magick/image/video previewers with mediainfo.
    prepend_previewers = [
      {
        mime = "{audio,video,image}/*";
        run = "mediainfo";
      }
      {
        mime = "application/subrip";
        run = "mediainfo";
      }
      # cover adobe illustrator/postscript separately from image/adobe.photoshop.
      {
        mime = "application/postscript";
        run = "mediainfo";
      }
    ];

    # replace default magick/image/video preloaders with mediainfo.
    prepend_preloaders = [
      {
        mime = "{audio,video,image}/*";
        run = "mediainfo";
      }
      {
        mime = "application/subrip";
        run = "mediainfo";
      }
      # cover adobe illustrator/postscript separately from image/adobe.photoshop.
      {
        mime = "application/postscript";
        run = "mediainfo";
      }
    ];
  };
}
