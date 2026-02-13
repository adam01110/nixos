_: {
  # Configure editing behavior, clipboard integration, and LSP defaults.
  programs.nvf.settings.vim = {
    searchCase = "smart";
    options.wrap = false;

    clipboard = {
      enable = true;
      providers.wl-copy.enable = true;
      registers = "unnamedplus";
    };

    telescope = {
      enable = true;
    };

    lsp = {
      enable = true;
      formatOnSave = true;
      lspSignature.enable = true;

      # Support embedded code blocks in mixed-language buffers.
      otter-nvim = {
        enable = true;
        setupOpts.handle_leading_whitespace = true;
      };
    };

    # Discourage repeated movement spam.
    binds.hardtime-nvim = {
      enable = true;

      setupOpts = {
        showmode = false;
        max_count = 2;
      };
    };
  };
}
