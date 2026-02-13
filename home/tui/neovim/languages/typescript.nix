_: {
  # Enable TypeScript support with Biome formatting and translated errors.
  programs.nvf.settings.vim.languages.ts = {
    enable = true;
    format.type = ["biome"];

    extensions.ts-error-translator = {
      enable = true;
      setupOpts.servers = ["ts_ls"];
    };
  };
}
