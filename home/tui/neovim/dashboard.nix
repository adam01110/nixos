{
  lib,
  pkgs,
  ...
}: let
  inherit (builtins) attrValues;
  inherit (lib) getExe;
  inherit (lib.generators) mkLuaInline;
in {
  # Configure snacks.nvim dashboard sections and startup footer.
  programs.nvf.settings.vim = {
    utility.snacks-nvim.setupOpts.dashboard = {
      enable = true;
      sections = [
        {section = "header";}
        {
          pane = 2;
          section = "terminal";
          cmd = "${getExe pkgs.dwt1-shell-color-scripts} -e square";
          height = 5;
          padding = [3 2];
        }
        {
          section = "keys";
          gap = 1;
          padding = 1;
        }
        {
          pane = 2;
          icon = " ";
          title = "Notifications";
          section = "terminal";
          cmd = "${getExe pkgs.gh-notify} -s -a -n4";
          height = 4;
          padding = 1;
          indent = 3;
          enabled = true;
        }
        {
          pane = 2;
          icon = " ";
          title = "Recent Files";
          section = "recent_files";
          indent = 2;
          padding = 1;
        }
        {
          pane = 2;
          icon = " ";
          title = "Projects";
          section = "projects";
          indent = 2;
          padding = 1;
        }
        {
          pane = 2;
          icon = " ";
          title = "Git Status";
          section = "terminal";
          enabled = mkLuaInline ''
            function()
              return Snacks.git.get_root() ~= nil
            end
          '';
          cmd = "git status --short --branch --renames";
          height = 5;
          padding = 1;
          indent = 3;
        }
        (mkLuaInline ''
          function()
            local ms = vim.g.snacks_start_ms
            if not ms and vim.g.snacks_start_ns then
              ms = (vim.uv.hrtime() - vim.g.snacks_start_ns) / 1e6
            end

            local packpath = vim.o.packpath
            local start_plugins = vim.fn.globpath(packpath, "pack/*/start/*", 0, 1)
            local opt_plugins = vim.fn.globpath(packpath, "pack/*/opt/*", 0, 1)
            local total = #start_plugins + #opt_plugins

            local loaded_start = 0
            local loaded_opt = 0
            for path in string.gmatch(vim.o.runtimepath, "([^,]+)") do
              if path:match("/pack/.+/start/[^/]+$") then
                loaded_start = loaded_start + 1
              elseif path:match("/pack/.+/opt/[^/]+$") then
                loaded_opt = loaded_opt + 1
              end
            end

            local loaded = loaded_start + loaded_opt
            local text = {
              { "󱐋 Neovim loaded ", hl = "SnacksDashboardFooter" },
              { string.format("%d/%d", loaded or 0, total or 0), hl = "SnacksDashboardKey" },
              { " plugins in ", hl = "SnacksDashboardFooter" },
              { string.format("%.2f ms", ms or 0), hl = "SnacksDashboardKey" },
            }

            return { text = text, padding = 1 }
          end
        '')
      ];
    };

    luaConfigPre = ''
      vim.g.snacks_start_ns = vim.uv.hrtime()
      vim.api.nvim_create_autocmd("UIEnter", {
        once = true,
        callback = function()
          vim.g.snacks_start_ms = (vim.uv.hrtime() - vim.g.snacks_start_ns) / 1e6
        end,
      })
    '';

    extraPackages = attrValues {
      inherit
        (pkgs)
        gh-notify
        dwt1-shell-color-scripts
        ;
    };
  };
}
