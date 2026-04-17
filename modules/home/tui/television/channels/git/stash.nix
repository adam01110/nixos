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
  programs.television.channels.git-stash = {
    # keep-sorted start block=yes newline_separated=yes
    actions = {
      # keep-sorted start block=yes newline_separated=yes
      apply = {
        description = "Apply the selected stash";
        command = "${git} stash apply '{strip_ansi|split:\\::0}'";
        mode = "execute";
      };

      drop = {
        description = "Drop the selected stash";
        command = "${git} stash drop '{strip_ansi|split:\\::0}'";
        mode = "execute";
      };

      pop = {
        description = "Pop the selected stash (apply and remove)";
        command = "${git} stash pop '{strip_ansi|split:\\::0}'";
        mode = "execute";
      };
      # keep-sorted end
    };

    keybindings = {
      # keep-sorted start
      ctrl-d = "actions:drop";
      ctrl-p = "actions:pop";
      enter = "actions:apply";
      # keep-sorted end
    };

    metadata = {
      name = "git-stash";
      description = "Browse and manage git stash entries";
      requirements = ["git"];
    };

    preview.command = "${git} stash show -p --color=always '{strip_ansi|split:\\::0}'";

    source = {
      # keep-sorted start
      ansi = true;
      command = "${git} stash list --color=always";
      frecency = false;
      no_sort = true;
      output = "{strip_ansi|split:\\::0}";
      # keep-sorted end
    };
    # keep-sorted end
  };
}
