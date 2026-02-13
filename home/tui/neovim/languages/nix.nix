_: {
  # Enable Nix support with the nixd language server.
  programs.nvf.settings.vim.languages.nix = {
    enable = true;
    lsp.servers = ["nixd"];
  };
}
