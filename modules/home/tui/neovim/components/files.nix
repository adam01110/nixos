{config, ...}: {
  programs.nvf.settings.vim.utility.yazi-nvim = {
    enable = true;

    setupOpts = {
      # keep-sorted start
      open_for_directories = true;
      yazi_floating_window_border = config.neovim.borderType;
      open_multiple_tabs = true;
      change_neovim_cwd_on_close = true;
      # keep-sorted end
    };
  };
}
