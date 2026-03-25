_: {
  # Enable Rust support with crates.nvim metadata helpers.
  programs.nvf.settings.vim.languages.rust = {
    enable = true;

    extensions.crates-nvim = {
      enable = true;
      setupOpts = {
      };
    };
  };
}
