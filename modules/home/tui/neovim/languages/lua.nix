_: {
  # Enable Lua support with selene diagnostics.
  programs.nvf.settings.vim.languages.lua = {
    enable = true;
    extraDiagnostics.types = ["selene"];
  };
}
