{pkgs, ...}: {
  # Discord rich presence via cord.nvim.
  programs.nvf.settings.vim.extraPlugins.cord = {
    package = pkgs.vimPlugins.cord-nvim;
    setup = ''
      local diagnostics = require("cord.plugins.diagnostics")
      diagnostics.config.scope = 0
      diagnostics.config.severity = { min = vim.diagnostic.severity.HINT }
      diagnostics.config.override = true

      local scoped_timestamps = require("cord.plugins.scoped_timestamps")
      scoped_timestamps.config.scope = "workspace"
      scoped_timestamps.config.pause = true

      require("cord").setup({
        editor = {
          tooltip = "Editing with Neovim",
        },
        display = {
          flavor = "accent",
        },
        plugins = {
          "cord.plugins.diagnostics",
          "cord.plugins.scoped_timestamps",
        },
        advanced = {
          discord = {
            reconnect = {
              enabled = true,
            },
          },
        },
      })
    '';
  };
}
