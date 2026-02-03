{pkgs, ...}: {
  imports = [
    ./dashboard.nix
    ./languages.nix
    ./presence.nix
    ./profiler.nix
    ./settings.nix
    ./scrollbar.nix
    ./ui.nix
  ];

  programs.nvf = {
    enable = true;
    enableManpages = true;

    settings.vim = {
      withNodeJs = true;
      withPython3 = true;
      enableLuaLoader = true;

      utility.snacks-nvim.enable = true;

      package = pkgs.neovim-nightly;
    };
  };

  stylix.targets.nvf.transparentBackground = true;
}
