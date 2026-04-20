_: {
  programs.nvf.settings.vim.git = {
    # keep-sorted start block=yes newline_separated=yes
    gitsigns = {
      enable = true;

      setupOpts = {
        # keep-sorted start block=yes newline_separated=yes
        signs = {
          # keep-sorted start
          add.text = "▎";
          change.text = "▎";
          delete.text = "";
          topdelete.text = "";
          changedelete.text = "▎";
          untracked.text = "┆";
          # keep-sorted end
        };

        signs_staged = {
          # keep-sorted start
          add.text = "▎";
          change.text = "▎";
          delete.text = "";
          topdelete.text = "";
          changedelete.text = "▎";
          untracked.text = "┆";
          # keep-sorted end
        };
        # keep-sorted end
      };
    };

    vim-fugitive.enable = true;
    # keep-sortede end
  };
}
