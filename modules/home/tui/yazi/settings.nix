_:
# Configure yazi file manager and preview settings.
let
  # Memory allocation for image previews in megabytes.
  imageAllocMB = 1024;
in {
  programs.yazi.settings = {
    # Manager settings control file browser appearance and behavior.
    mgr = {
      ratio = [
        1
        2
        2
      ];

      # keep-sorted start
      linemode = "size_mtime";
      scrolloff = 10;
      # keep-sorted end

      # keep-sorted start
      show_hidden = true;
      sort_by = "natural";
      sort_translit = true;
      # keep-sorted end
    };

    # Preview settings control file preview quality and dimensions.
    preview = {
      # keep-sorted start
      image_delay = 0;
      image_filter = "lanczos3";
      image_quality = 90;
      # keep-sorted end

      # keep-sorted start
      max_height = 1200;
      max_width = 900;
      # keep-sorted end
    };

    # Control memory used by image previews.
    tasks.image_alloc = imageAllocMB * 1024 * 1024;

    # keep-sorted start
    input.cursor_blink = false;
    which.sort_translit = true;
    # keep-sorted end
  };
}
