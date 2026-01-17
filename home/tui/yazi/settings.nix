_: let
  # memory allocation for image previews in megabytes.
  imageAllocMB = 1024;
in {
  programs.yazi.settings = {
    # manager settings control file browser appearance and behavior.
    mgr = {
      ratio = [
        1
        2
        2
      ];
      linemode = "size_mtime";
      scrolloff = 10;

      sort_by = "natural";
      sort_translit = true;
      show_hidden = true;
    };

    # preview settings control file preview quality and dimensions.
    preview = {
      image_filter = "lanczos3";
      image_quality = 90;
      image_delay = 0;

      max_width = 900;
      max_height = 1200;
    };

    # control memory used by image previews.
    tasks.image_alloc = imageAllocMB * 1024 * 1024;

    input.cursor_blink = false;
    which.sort_translit = true;
  };
}
