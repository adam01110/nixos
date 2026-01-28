_: {
  programs.nvf.settings.vim.languages = {
    enableFormat = true;
    enableTreesitter = true;
    enableExtraDiagnostics = true;

    yaml.enable = true;
    lua.enable = true;
    html.enable = true;
    tailwind.enable = true;
    bash.enable = true;
    json.enable = true;

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

      extensions.render-markdown-nvim = {
        enable = true;
        setupOpts = {};
      };
    };
  };
}
