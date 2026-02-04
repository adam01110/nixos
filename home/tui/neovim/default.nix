{pkgs, ...}: {
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

  home.sessionVariables = let
    editor = "nvim";
  in {
    EDITOR = editor;
    VISUAL = editor;
  };

  stylix.targets.nvf.transparentBackground = true;
}
