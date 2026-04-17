{
  # keep-sorted start
  config,
  lib,
  # keep-sorted end
  ...
}: let
  inherit (lib) getExe;

  git = getExe config.programs.git.package;
in {
  programs.television.channels.git-reflog = {
    # keep-sorted start block=yes newline_separated=yes
    actions = {
      # keep-sorted start block=yes newline_separated=yes
      checkout = {
        description = "Checkout the selected reflog entry";
        command = "${git} checkout '{0|strip_ansi}'";
        mode = "execute";
      };

      reset = {
        description = "Reset --hard to the selected reflog entry";
        command = "${git} reset --hard '{0|strip_ansi}'";
        mode = "execute";
      };
      # keep-sorted end
    };

    keybindings = {
      # keep-sorted start
      ctrl-o = "actions:checkout";
      ctrl-r = "actions:reset";
      # keep-sorted end
    };

    metadata = {
      name = "git-reflog";
      description = "A channel to select from git reflog entries";
      requirements = ["git"];
    };

    preview.command = "${git} show --stat --color=always '{0|strip_ansi}'";

    source = {
      # keep-sorted start block=yes newline_separated=yes
      ansi = true;

      command = "${git} reflog --decorate --color=always";

      frecency = false;

      no_sort = true;

      output = "{0|strip_ansi}";
      # keep-sorted end
    };
    # keep-sorted end
  };
}
