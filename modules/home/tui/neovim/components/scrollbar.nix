{pkgs, ...}:
# Add satellite.nvim scrollbar indicators.
{
  programs.nvf.settings.vim.lazy.plugins."satellite.nvim" = {
    package = pkgs.vimPlugins.satellite-nvim;

    # keep-sorted start block=yes newline_separated=yes
    event = [
      {
        event = "User";
        pattern = "LazyFile";
      }
    ];

    setupModule = "satellite";

    setupOpts = {
      current_only = true;
    };
    # keep-sorted end
  };
}
