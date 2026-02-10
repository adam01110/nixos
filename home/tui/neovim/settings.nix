_: {
  programs.nvf.settings.vim = {
    searchCase = "smart";
    options.wrap = false;

    clipboard = {
      enable = true;
      providers.wl-copy.enable = true;
      registers = "unnamedplus";
    };

    spellcheck = {
      enable = true;

      # run :DirtytalkUpdate on first use to download the spellfile.
      programmingWordlist.enable = true;
    };

    telescope = {
      enable = true;

      # Keep Telescope borders in explicit single-line style.
      setupOpts.defaults = {
        border = true;
        borderchars = ["─" "│" "─" "│" "┌" "┐" "┘" "└"];
      };
    };

    lsp = {
      enable = true;
      formatOnSave = true;
      lspSignature.enable = true;

      otter-nvim = {
        enable = true;
        setupOpts.handle_leading_whitespace = true;
      };
    };

    binds.hardtime-nvim = {
      enable = true;

      setupOpts = {
        showmode = false;
        max_count = 2;
      };
    };
  };
}
