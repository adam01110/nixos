_:
# Configure neovim via nvf and set editor defaults.
{
  programs.nvf = {
    enable = true;
    enableManpages = true;

    settings.vim = {
      enableLuaLoader = true;
      utility.snacks-nvim.enable = true;
    };
  };

  # Export editor vars for cli tools.
  home.sessionVariables = let
    editor = "nvim";
  in {
    EDITOR = editor;
    VISUAL = editor;
  };
}
