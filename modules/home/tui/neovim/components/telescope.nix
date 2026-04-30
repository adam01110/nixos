{pkgs, ...}: {
  neovim.luaConfigPreSnippets = [
    # Install Telescope as the global vim.ui.select provider after UI startup.
    ''
      vim.api.nvim_create_autocmd("User", {
        pattern = "DeferredUIEnter",
        once = true,
        callback = function()
          pcall(function()
            require("telescope").load_extension("ui-select")
          end)
        end,
      })
    ''
  ];

  programs.nvf.settings.vim = {
    # keep-sorted start block=yes newline_separated=yes
    highlight = {
      # keep-sorted start
      TelescopeBorder.link = "FloatBorder";
      TelescopePreviewBorder.link = "FloatBorder";
      TelescopePromptBorder.link = "FloatBorder";
      TelescopeResultsBorder.link = "FloatBorder";
      # keep-sorted end
    };

    # Keep Telescope borders in explicit single-line style.
    telescope = {
      enable = true;

      extensions = [
        # keep-sorted start block=yes newline_separated=yes
        {
          name = "fzf";
          packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
        }

        {
          name = "ui-select";
          packages = [pkgs.vimPlugins.telescope-ui-select-nvim];
        }
        # keep-sorted end
      ];

      setupOpts.defaults = {
        border = true;
        borderchars = ["─" "│" "─" "│" "┌" "┐" "┘" "└"];
      };
    };
    # keep-sorted end
  };
}
