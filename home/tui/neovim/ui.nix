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
  };
}
