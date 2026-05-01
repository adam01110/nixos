{pkgs, ...}: {
  programs.nvf.settings.vim = {
    binds = {
      whichKey = {
        enable = true;
        setupOpts.preset = "helix";
      };
    };

    lazy.plugins."noCheatSheet.nvim" = {
      cmd = "Cheatsheet";
      package = pkgs.nocheatsheet-nvim;
      setupModule = "nocheatsheet";
    };
  };
}
