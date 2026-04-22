{lib, ...}: let
  inherit
    (lib)
    # keep-sorted start
    mkOption
    types
    # keep-sorted end
    ;
in {
  options.neovim.borderType = mkOption {
    type = types.str;
    default = "single";
    description = "Border style for Neovim floating UI.";
  };

  config = {
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
      # keep-sorted start
      EDITOR = editor;
      VISUAL = editor;
      # keep-sorted end
    };
  };
}
