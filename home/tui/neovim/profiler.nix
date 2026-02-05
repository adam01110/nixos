_:
# Enable snacks.nvim profiler options and toggle keymap.
{
  programs.nvf.settings.vim = {
    utility.snacks-nvim.setupOpts.profiler = {
      autocmds = true;

      filter_mod.default = false;
      filter_fn.default = false;

      icons = {
        require = " ";
        file = " ";
      };
    };

    keymaps = [
      {
        key = "<leader>pp";
        mode = "n";
        action = "<cmd>lua Snacks.profiler.toggle()<CR>";
        desc = "Profiler Toggle";
      }
    ];
  };
}
