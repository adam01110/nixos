_: {
  # Enable Python support with Ruff formatting and ty LSP.
  programs.nvf.settings.vim.languages.python = {
    enable = true;
    format.type = ["ruff"];
    lsp.servers = ["ty"];
  };
}
