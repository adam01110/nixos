{pkgs, ...}:
# configure neovim via nvf and set editor defaults.
{
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

  # export editor vars for cli tools.
  home.sessionVariables = let
    editor = "nvim";
  in {
    EDITOR = editor;
    VISUAL = editor;
  };

  # keep nvf background transparent in the stylix.
  stylix.targets.nvf.transparentBackground = true;
}
