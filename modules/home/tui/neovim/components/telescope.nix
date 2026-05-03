{
  # keep-sorted start
  osConfig,
  pkgs,
  # keep-sorted end
  ...
}: let
  colors = osConfig.lib.stylix.colors.withHashtag;
in {
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

    # Override all devicon highlight groups to use base0E as foreground.
    ''
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("NixosTelescopeDevicons", { clear = true }),
        callback = function()
          vim.defer_fn(function()
            local ok, devicons = pcall(require, "nvim-web-devicons")
            if not ok then return end
            local icons = devicons.get_icons()
            for _, data in pairs(icons) do
              if data.name then
                vim.api.nvim_set_hl(0, "DevIcon" .. data.name, { fg = "${colors.base0E}" })
              end
            end
            vim.api.nvim_set_hl(0, "DevIconDefault", { fg = "${colors.base0E}" })
          end, 0)
        end,
      })
    ''
  ];

  programs.nvf.settings.vim = {
    # keep-sorted start block=yes newline_separated=yes
    highlight = {
      # keep-sorted start
      TelescopeBorder.fg = colors.base04;
      TelescopeNormal.bg = colors.base00;
      TelescopePreviewBorder.fg = colors.base04;
      TelescopePreviewNormal.bg = colors.base00;
      TelescopePromptBorder.fg = colors.base04;
      TelescopePromptCounter.bg = colors.base00;
      TelescopePromptNormal.bg = colors.base00;
      TelescopePromptPrefix.bg = colors.base00;
      TelescopeResultsBorder.fg = colors.base04;
      TelescopeResultsNormal.bg = colors.base00;
      TelescopeResultsTitle.bg = colors.base0E;
      TelescopeResultsTitle.fg = colors.base00;
      # keep-sorted end
    };

    lazy.plugins."telescope-all-recent.nvim" = {
      event = {
        event = "User";
        pattern = "DeferredUIEnter";
      };
      package = pkgs.telescope-all-recent-nvim;
      setupModule = "telescope-all-recent";
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
        selection_caret = ">";
      };
    };
    # keep-sorted end
  };
}
