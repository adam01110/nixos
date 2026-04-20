{config, ...}: {
  programs.nvf.settings.vim.utility.yazi-nvim = {
    enable = true;

    setupOpts = {
      open_for_directories = true;
      yazi_floating_window_border = config.neovim.borderType;
    };
  };
}
