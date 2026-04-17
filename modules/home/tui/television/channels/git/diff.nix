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
  programs.television.channels.git-diff = {
    # keep-sorted start block=yes newline_separated=yes
    actions = {
      # keep-sorted start block=yes newline_separated=yes
      edit = {
        description = "Open the selected file in editor";
        command = "$EDITOR '{}'";
        mode = "execute";
      };

      restore = {
        description = "Discard changes in the selected file";
        command = "${git} restore '{}'";
        mode = "fork";
      };

      stage = {
        description = "Stage the selected file";
        command = "${git} add '{}'";
        mode = "fork";
      };
      # keep-sorted end
    };

    keybindings = {
      # keep-sorted start
      ctrl-e = "actions:edit";
      ctrl-r = "actions:restore";
      ctrl-s = "actions:stage";
      # keep-sorted end
    };

    metadata = {
      name = "git-diff";
      description = "A channel to select files from git diff commands";
      requirements = [
        # keep-sorted start
        "bash"
        "git"
        # keep-sorted end
      ];
    };

    preview.command = "git diff HEAD --color=always -- '{}'";

    source.command = "${git} diff --name-only HEAD";
    # keep-sorted end
  };
}
