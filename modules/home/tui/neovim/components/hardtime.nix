_: {
  programs.nvf.settings.vim.binds.hardtime-nvim = {
    enable = true;

    setupOpts = {
      # keep-sorted start
      showmode = false;
      max_count = 4;
      restriction_mode = "hint";
      disable_mouse = false;
      # keep-sorted end
    };
  };
}
