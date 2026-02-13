{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  programs.nvf.settings.vim = {
    # Enable Markdown support with rumdl and rich markview rendering.
    languages.markdown = {
      enable = true;

      lsp.servers = ["rumdl"];
      format.type = ["rumdl"];
      extraDiagnostics.types = ["rumdl"];

      extensions.markview-nvim = {
        enable = true;

        # Tune markview for icon-backed previews and table rendering.
        setupOpts = {
          preview = {
            icon_provider = "devicons";
            filetypes = ["markdown"];

            linewise_hybrid_mode = true;

            modes = [
              "n"
              "no"
              "v"
              "V"
              "i"
            ];
            hybrid_modes = [
              "n"
              "v"
              "V"
            ];
          };

          experimental.prefer_nvim = true;

          markdown = {
            enable = true;
            use_virt_lines = true;

            tables.parts = {
              top = ["┌" "─" "┐" "┬"];
              bottom = ["└" "─" "┘" "┴"];
              overlap = ["├" "─" "┤" "┼"];
              align_left = "─";
              align_right = "─";
              align_center = ["─" "─"];
            };

            headings = {
              heading_1.icon = "󰎤 ";
              heading_2.icon = "󰎧 ";
              heading_3.icon = "󰎪 ";
              heading_4.icon = "󰎭 ";
              heading_5.icon = "󰎱 ";
              heading_6.icon = "󰎳 ";

              setext_1.icon = "󰎤 ";
              setext_2.icon = "󰎧 ";
            };
          };
        };
      };
    };

    # Pass the required `fmt` subcommand so conform can run rumdl.
    formatter.conform-nvim.setupOpts.formatters.rumdl = {
      command = "rumdl";

      args = [
        "fmt"
        "-"
      ];
    };

    # Provide a parser for rumdl until nvim-lint ships one.
    diagnostics.nvim-lint.linters.rumdl = {
      args = [
        "check"
        "--output-format"
        "json"
      ];
      stdin = false;
      append_fname = true;
      stream = "stdout";
      ignore_exitcode = true;
      parser = mkLuaInline ''
        function(output)
          local diagnostics = {}
          local ok, results = pcall(vim.json.decode, output)
          if not ok then
            return diagnostics
          end

          for _, result in ipairs(results or {}) do
            local severity = vim.diagnostic.severity.WARN
            if result.severity == "error" then
              severity = vim.diagnostic.severity.ERROR
            elseif result.severity == "info" then
              severity = vim.diagnostic.severity.INFO
            elseif result.severity == "hint" then
              severity = vim.diagnostic.severity.HINT
            end

            table.insert(diagnostics, {
              lnum = (result.line or 1) - 1,
              col = (result.column or 1) - 1,
              message = result.message or "",
              code = result.rule,
              severity = severity,
              source = "rumdl",
            })
          end

          return diagnostics
        end
      '';
    };

    # Add a shortcut to toggle markview rendering.
    keymaps = [
      {
        key = "<leader>m";
        mode = "n";
        action = "<CMD>Markview<CR>";
        desc = "Toggle `markview` globally";
      }
    ];

    # Apply prose-friendly wrapping and width guidance for markdown buffers.
    augroups = [{name = "MarkdownEditing";}];
    autocmds = [
      {
        event = ["FileType"];
        pattern = ["markdown"];
        group = "MarkdownEditing";
        desc = "Enable markdown wrap and line length hints";
        command = "setlocal wrap linebreak textwidth=80 colorcolumn=+1 formatoptions+=t";
      }
    ];
  };
}
