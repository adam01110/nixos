{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  programs.nvf.settings.vim = let
    borderType = "single";
  in {
    ui = {
      borders = {
        enable = true;
        globalStyle = borderType;

        plugins.which-key = {
          enable = true;
          style = borderType;
        };
      };

      noice = {
        enable = true;

        setupOpts = {
          # Keep using `nvim-notify` and avoid noice overwrite warnings.
          notify.enabled = false;

          # Avoid hooking hover and markdown helpers that other plugins replace.
          lsp = {
            hover.enabled = false;

            override = {
              # keep-sorted start
              "vim.lsp.util.convert_input_to_markdown_lines" = false;
              "vim.lsp.util.stylize_markdown" = false;
              # keep-sorted end
            };
          };

          views = {
            # keep-sorted start
            cmdline_popup.border.style = borderType;
            popup.border.style = borderType;
            popupmenu.border.style = borderType;
            # keep-sorted end
          };
        };
      };
    };

    visuals = {
      nvim-web-devicons.enable = true;
    };

    notify.nvim-notify = {
      enable = true;

      setupOpts = {
        render = "default";
        stages = "fade";

        on_open = mkLuaInline ''
          function(win)
            vim.api.nvim_win_set_config(win, { border = ${borderType} })
          end
        '';
      };
    };

    # Keep Telescope border windows visible with themes that flatten border groups.
    highlight = {
      # keep-sorted start
      TelescopeBorder.link = "FloatBorder";
      TelescopePreviewBorder.link = "FloatBorder";
      TelescopePromptBorder.link = "FloatBorder";
      TelescopeResultsBorder.link = "FloatBorder";
      # keep-sorted end
    };

    # Keep Telescope borders in explicit single-line style.
    telescope.setupOpts.defaults = {
      border = true;
      borderchars = ["─" "│" "─" "│" "┌" "┐" "┘" "└"];
    };
  };
}
