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
  programs.television.channels.git-remotes = {
    # keep-sorted start block=yes newline_separated=yes
    actions = {
      # keep-sorted start block=yes newline_separated=yes
      fetch = {
        description = "Fetch from the selected remote";
        command = "${git} fetch '{}'";
        mode = "execute";
      };

      remove = {
        description = "Remove the selected remote";
        command = "${git} remote remove '{}'";
        mode = "execute";
      };
      # keep-sorted end
    };

    keybindings = {
      # keep-sorted start
      ctrl-d = "actions:remove";
      enter = "actions:fetch";
      # keep-sorted end
    };

    metadata = {
      name = "git-remotes";
      description = "List and manage git remotes";
      requirements = ["git"];
    };

    preview.command = "${git} remote show '{}'";

    source.command = "${git} remote";
    # keep-sorted end
  };
}
