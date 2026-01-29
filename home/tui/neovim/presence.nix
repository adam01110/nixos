{pkgs, ...}: {
  # discord rich presence via cord.nvim.
  programs.nvf.settings.vim.extraPlugins.cord = {
    package = pkgs.vimPlugins.cord-nvim;
    setup = ''
      require("cord").setup({
        editor = {
          tooltip = "Editing with Neovim",
        },
        display = {
          flavor = "accent",
          view = "auto",
        },
        timestamp = {
          shared = true,
        },
        advanced = {
          discord = {
            reconnect = {
              enabled = true,
            },
          },
        },
        plugins = {
          ["cord.plugins.diagnostics"] = {
            severity = vim.diagnostic.severity.HINT,
          },
        },
      })
    '';
  };
}
