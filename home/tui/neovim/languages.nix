_: {
  programs.nvf.settings.vim = {
    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      yaml.enable = true;
      lua.enable = true;
      html.enable = true;
      tailwind.enable = true;
      bash.enable = true;
      json.enable = true;
      xml.enable = true;

      nix = {
        enable = true;
        lsp.servers = ["nixd"];
      };

      python = {
        enable = true;
        format.type = ["ruff"];
        lsp.servers = ["ty"];
      };

      css = {
        enable = true;
        format.type = ["biome"];
      };

      ts = {
        enable = true;
        format.type = ["biome"];

        extensions.ts-error-translator = {
          enable = true;
          setupOpts.servers = ["ts_ls"];
        };
      };

      rust = {
        enable = true;

        extensions.crates-nvim = {
          enable = true;
          setupOpts = {};
        };
      };

      markdown = {
        enable = true;
        lsp.servers = ["markdown-oxide"];

        extensions.markview-nvim = {
          enable = true;

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
    };

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
