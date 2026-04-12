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
  programs.television.channels.git-branch = {
    # keep-sorted start block=yes newline_separated=yes
    actions = {
      # keep-sorted start block=yes newline_separated=yes
      checkout = {
        description = "Checkout the selected branch";
        command = "${git} checkout '{0}'";
        mode = "execute";
      };

      delete = {
        description = "Delete the selected branch";
        command = "${git} branch -d '{0}'";
        mode = "execute";
      };

      merge = {
        description = "Merge the selected branch into current branch";
        command = "${git} merge '{0}'";
        mode = "execute";
      };

      rebase = {
        description = "Rebase current branch onto the selected branch";
        command = "${git} rebase '{0}'";
        mode = "execute";
      };
      # keep-sorted end
    };

    keybindings = {
      # keep-sorted start
      ctrl-d = "actions:delete";
      ctrl-m = "actions:merge";
      ctrl-r = "actions:rebase";
      enter = "actions:checkout";
      # keep-sorted end
    };

    metadata = {
      name = "git-branch";
      description = "A channel to select from git branches";
      requirements = ["git"];
    };

    preview.command = "${git} show --stat --color=always '{0}'";

    source = {
      command = "${git} --no-pager branch --all --format=\"%(refname:short)\"";
      output = "{split: :0}";
    };
    # keep-sorted end
  };
}
