_: {
  programs.nvf.settings.vim = {
    keymaps = [
      # keep-sorted start block=yes newline_separated=yes
      {
        key = "<leader>q";
        mode = "n";
        action = "<cmd>q<cr>";
      }

      {
        key = "<leader>w";
        mode = "n";
        action = "<cmd>w<cr>";
      }

      {
        key = "<leader>x";
        mode = "n";
        action = "<cmd>x<cr>";
      }
      # keep-sorted end
    ];
  };
}
