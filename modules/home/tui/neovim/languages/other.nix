_: {
  # Enable shared language support with formatting, Treesitter, and diagnostics.
  programs.nvf.settings.vim.languages = {
    enableFormat = true;
    enableTreesitter = true;
    enableExtraDiagnostics = true;

    yaml.enable = true;
    html.enable = true;
    tailwind.enable = true;
    bash.enable = true;
    json.enable = true;
    xml.enable = true;
    toml.enable = true;
  };
}
