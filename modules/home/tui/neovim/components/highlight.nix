{
  # keep-sorted start
  lib,
  # keep-sorted end
  ...
}: let
  inherit (lib.generators) mkLuaInline;
in {
  programs.nvf.settings.vim = {
    # keep-sorted start block=yes newline_separated=yes
    mini.hipatterns = {
      enable = true;

      setupOpts.highlighters = {
        hex_color = mkLuaInline "require('mini.hipatterns').gen_highlighter.hex_color()";

        # keep-sorted start block=yes newline_separated=yes
        fixme = {
          pattern = "%f[%w]()FIXME()%f[%W]";
          group = "MiniHipatternsFixme";
        };

        hack = {
          pattern = "%f[%w]()HACK()%f[%W]";
          group = "MiniHipatternsHack";
        };

        note = {
          pattern = "%f[%w]()NOTE()%f[%W]";
          group = "MiniHipatternsNote";
        };

        todo = {
          pattern = "%f[%w]()TODO()%f[%W]";
          group = "MiniHipatternsTodo";
        };
        # keep-sorted end
      };
    };
    # keep-sorted end
  };
}
