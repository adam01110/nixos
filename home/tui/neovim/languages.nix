_: {
  programs.nvf.settings.vim.languages = {
    enableFormat = true;
    enableTreesitter = true;
    enableExtraDiagnostics = true;

    yaml.enable = true;
    lua.enable = true;
    html.enable = true;
    tailwind.enable = true;

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

    markdown = {
      enable = true;
    };
  };
}
