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
            linewise_hybrid_mode = true;

            icon_provider = "devicons";
            filetypes = ["markdown"];

            modes = [
              # keep-sorted start
              "V"
              "i"
              "n"
              "no"
              "v"
              # keep-sorted end
            ];
            hybrid_modes = [
              # keep-sorted start
              "V"
              "n"
              "v"
              # keep-sorted end
            ];
          };

          experimental.prefer_nvim = true;

          markdown = {
            enable = true;
            use_virt_lines = true;

            tables.parts = {
              # keep-sort start
              top = ["┌" "─" "┐" "┬"];
              bottom = ["└" "─" "┘" "┴"];
              overlap = ["├" "─" "┤" "┼"];
              align_left = "─";
              align_right = "─";
              align_center = ["─" "─"];
              # keep-sort end
            };

            headings = {
              # keep-sort start numeric=yes
              heading_1.icon = "󰎤 ";
              heading_2.icon = "󰎧 ";
              heading_3.icon = "󰎪 ";
              heading_4.icon = "󰎭 ";
              heading_5.icon = "󰎱 ";
              heading_6.icon = "󰎳 ";
              # keep-sort end

              # keep-sort start numeric=yes
              setext_1.icon = "󰎤 ";
              setext_2.icon = "󰎧 ";
              # keep-sort end
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
  };
}
