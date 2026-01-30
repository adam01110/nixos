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
            };

            markdown = {
              enable = true;
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
