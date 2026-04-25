{
  # keep-sorted start
  lib,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (builtins) attrValues;
  inherit (lib) getExe;
  inherit (lib.generators) mkLuaInline;
in {
  # keep-sorted start block=yes newline_separated=yes
  # Capture startup timing early and finalize after UI attach.
  neovim.luaConfigPreSnippets = [
    # Track startup duration for the custom dashboard footer metrics.
    ''
      vim.g.snacks_start_ns = vim.uv.hrtime()

      vim.api.nvim_create_autocmd("UIEnter", {
        once = true,
        callback = function()
          vim.g.snacks_start_ms = (vim.uv.hrtime() - vim.g.snacks_start_ns) / 1e6
        end,
      })
    ''

    # Keep dashboard labels and file/project icons on the requested colors.
    ''

      local function apply_dashboard_highlights()
        vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { link = "Function" })
        vim.api.nvim_set_hl(0, "SnacksDashboardFileIcon", { link = "Function" })
        vim.api.nvim_set_hl(0, "SnacksDashboardDirIcon", { link = "Function" })
      end

      apply_dashboard_highlights()

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = apply_dashboard_highlights,
      })
    ''

    # Adjust local UI behavior while the Snacks dashboard buffer is active.
    ''
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "snacks_dashboard",
        callback = function()
          vim.opt_local.scrolloff = 0
          vim.b.snacks_scroll = false

          if vim.g.dashboard_saved_mouse == nil then
            vim.g.dashboard_saved_mouse = vim.go.mouse
          end

          vim.go.mouse = ""

          local group = vim.api.nvim_create_augroup("dashboard_mouse_restore", { clear = true })
          local function restore_mouse()
            local saved_mouse = vim.g.dashboard_saved_mouse
            if vim.bo.filetype == "snacks_dashboard" or saved_mouse == nil then
              return
            end

            vim.go.mouse = saved_mouse
            vim.g.dashboard_saved_mouse = nil
            pcall(vim.api.nvim_del_augroup_by_id, group)
          end

          vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
            group = group,
            callback = restore_mouse,
          })

          vim.schedule(function()
            vim.o.laststatus = 3
            vim.o.showtabline = 2
            require("lualine").refresh({ force = true, place = { "statusline", "tabline" } })
          end)
        end,
      })
    ''
  ];

  programs.nvf.settings.vim = {
    utility.snacks-nvim.setupOpts.dashboard = {
      enable = true;

      formats.icon = mkLuaInline ''
        function(item)
          if item.file and (item.icon == "file" or item.icon == "directory") then
            local icon = Snacks.dashboard.icon(item.file, item.icon)
            icon.hl = item.icon == "directory" and "SnacksDashboardDirIcon" or "SnacksDashboardFileIcon"
            return icon
          end

          return { item.icon, width = 1, hl = "icon" }
        end
      '';

      # keep-sorted start block=yes newline_separated=yes
      # Define dashboard shortcuts explicitly and omit the default Config entry.
      preset.keys = [
        {
          icon = " ";
          key = "f";
          desc = "Find File";
          action = ":lua Snacks.dashboard.pick('files')";
          text = mkLuaInline ''
            {
              { " ", hl = "SnacksDashboardIcon" },
              { "Find File", hl = "SnacksDashboardDesc", width = 50 },
              { "f", hl = "SnacksDashboardKey" },
            }
          '';
        }
        {
          icon = " ";
          key = "n";
          desc = "New File";
          action = ":ene | startinsert";
          text = mkLuaInline ''
            {
              { " ", hl = "SnacksDashboardIcon" },
              { "New File", hl = "SnacksDashboardDesc", width = 50 },
              { "n", hl = "SnacksDashboardKey" },
            }
          '';
        }
        {
          icon = " ";
          key = "g";
          desc = "Find Text";
          action = ":lua Snacks.dashboard.pick('live_grep')";
          text = mkLuaInline ''
            {
              { " ", hl = "SnacksDashboardIcon" },
              { "Find Text", hl = "SnacksDashboardDesc", width = 50 },
              { "g", hl = "SnacksDashboardKey" },
            }
          '';
        }
        {
          icon = " ";
          key = "r";
          desc = "Recent Files";
          action = ":lua Snacks.dashboard.pick('oldfiles')";
          text = mkLuaInline ''
            {
              { " ", hl = "SnacksDashboardIcon" },
              { "Recent Files", hl = "SnacksDashboardDesc", width = 50 },
              { "r", hl = "SnacksDashboardKey" },
            }
          '';
        }
        {
          icon = " ";
          key = "s";
          desc = "Restore Session";
          action = ":SessionManager load_session";
          text = mkLuaInline ''
            {
              { " ", hl = "SnacksDashboardIcon" },
              { "Restore Session", hl = "SnacksDashboardDesc", width = 50 },
              { "s", hl = "SnacksDashboardKey" },
            }
          '';
        }
        {
          icon = " ";
          key = "q";
          desc = "Quit";
          action = ":qa";
          text = mkLuaInline ''
            {
              { " ", hl = "SnacksDashboardIcon" },
              { "Quit", hl = "SnacksDashboardDesc", width = 50 },
              { "q", hl = "SnacksDashboardKey" },
            }
          '';
        }
      ];

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
          icon = "";
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
          icon = "";
          title = "Recent Files";
          section = "recent_files";
          indent = 2;
          padding = 1;
        }
        {
          pane = 2;
          icon = "";
          title = "Projects";
          section = "projects";
          indent = 2;
          padding = 1;
        }
        {
          pane = 1;
          icon = "";
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
        # Render startup metrics based on loaded runtime plugins.
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
              { "󱐋 ", hl = "SnacksDashboardIcon" },
              { "Neovim loaded ", hl = "SnacksDashboardFooter" },
              { string.format("%d/%d", loaded or 0, total or 0), hl = "SnacksDashboardKey" },
              { " plugins in ", hl = "SnacksDashboardFooter" },
              { string.format("%.2f ms", ms or 0), hl = "SnacksDashboardKey" },
            }

            return { text = text, padding = 1 }
          end
        '')
      ];
      # keep-sorted end
    };

    # Provide CLI tools consumed by dashboard terminal sections.
    extraPackages = attrValues {
      inherit
        (pkgs)
        # keep-sorted start
        dwt1-shell-color-scripts
        gh-notify
        # keep-sorted end
        ;
    };
  };
  # keep-sorted end
}
