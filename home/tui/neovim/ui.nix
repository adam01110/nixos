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
              "vim.lsp.util.convert_input_to_markdown_lines" = false;
              "vim.lsp.util.stylize_markdown" = false;
            };
          };

          views = {
            popup.border.style = borderType;
            popupmenu.border.style = borderType;
            cmdline_popup.border.style = borderType;
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
      TelescopeBorder.link = "FloatBorder";
      TelescopePromptBorder.link = "FloatBorder";
      TelescopeResultsBorder.link = "FloatBorder";
      TelescopePreviewBorder.link = "FloatBorder";
    };

    # Keep Telescope borders in explicit single-line style.
    telescope.setupOpts.defaults = {
      border = true;
      borderchars = ["─" "│" "─" "│" "┌" "┐" "┘" "└"];
    };
  };
}
