_: {
  programs.nvf.settings.vim = {
    searchCase = "smart";
    options = {
      # keep-sorted start
      mouse = "a";
      wrap = false;
      # keep-sorted end
    };

    # keep-sorted start block=yes newline_separated=yes
    clipboard = {
      enable = true;
      providers.wl-copy.enable = true;
      registers = "unnamedplus";
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
    # keep-sorted end
  };
}
