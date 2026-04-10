_: {
  programs.nvf.settings.vim.languages.ts = {
    enable = true;
    format.type = ["biome"];

    extensions.ts-error-translator = {
      enable = true;
      setupOpts.servers = ["ts_ls"];
    };
  };
}
