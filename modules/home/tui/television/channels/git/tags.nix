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
  programs.television.channels.git-tags = {
    # keep-sorted start block=yes newline_separated=yes
    actions = {
      # keep-sorted start block=yes newline_separated=yes
      checkout = {
        description = "Checkout the selected tag";
        command = "${git} checkout '{}'";
        mode = "execute";
      };

      delete = {
        description = "Delete the selected tag";
        command = "${git} tag -d '{}'";
        mode = "execute";
      };
      # keep-sorted end
    };

    keybindings = {
      # keep-sorted start
      ctrl-d = "actions:delete";
      enter = "actions:checkout";
      # keep-sorted end
    };

    metadata = {
      name = "git-tags";
      description = "Browse and checkout git tags";
      requirements = ["git"];
    };

    preview.command = "${git} --no-pager show --stat --color=always '{}' | head -n 1000";

    source = {
      # keep-sorted start block=yes newline_separated=yes
      command = "${git} tag --sort=-creatordate";

      frecency = false;

      no_sort = true;
      # keep-sorted end
    };
    # keep-sorted end
  };
}
