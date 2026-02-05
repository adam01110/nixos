{pkgs, ...}:
# Add satellite.nvim scrollbar indicators.
{
  programs.nvf.settings.vim.lazy.plugins."satellite.nvim" = {
    package = pkgs.vimPlugins.satellite-nvim;
    setupModule = "satellite";
    event = [
      {
        event = "User";
        pattern = "LazyFile";
      }
    ];
    setupOpts = {
      current_only = true;
    };
  };
}
