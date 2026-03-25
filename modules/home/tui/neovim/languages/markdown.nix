_: {
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

    # Add a shortcut to toggle markview rendering.
    keymaps = [
      {
        key = "<leader>m";
        mode = "n";
        action = "<CMD>Markview<CR>";
        desc = "Toggle `markview` globally";
      }
    ];

    # Apply prose-friendly wrapping and auto-reflow for markdown buffers.
    augroups = [{name = "MarkdownEditing";}];
    autocmds = [
      {
        event = ["FileType"];
        pattern = ["markdown"];
        group = "MarkdownEditing";
        desc = "Enable markdown wrapping at 120 columns without a guide line";
        command = "setlocal wrap linebreak breakindent textwidth=120 colorcolumn= formatoptions+=ta formatexpr= formatprg=";
      }
      {
        event = ["BufWritePre"];
        pattern = ["*.md"];
        group = "MarkdownEditing";
        desc = "Reflow the full markdown buffer to 120 columns before save";
        command = "setlocal formatexpr= formatprg= | keepjumps normal! gggqG";
      }
    ];
  };
}
