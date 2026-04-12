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
  programs.television.channels.git-submodules = {
    # keep-sorted start block=yes newline_separated=yes
    actions = {
      # keep-sorted start block=yes newline_separated=yes
      sync = {
        description = "Sync the selected submodule URL";
        command = "${git} submodule sync '{}'";
        mode = "execute";
      };

      update = {
        description = "Update the selected submodule";
        command = "${git} submodule update --init --recursive '{}'";
        mode = "execute";
      };
      # keep-sorted end
    };

    keybindings = {
      # keep-sorted start
      ctrl-s = "actions:sync";
      enter = "actions:update";
      # keep-sorted end
    };

    metadata = {
      name = "git-submodules";
      description = "List and manage git submodules";
      requirements = ["git"];
    };

    preview.command = "${git} -C '{}' log --oneline -10 --color=always";

    source.command = "${git} submodule status | awk '{print \$2}'";
    # keep-sorted end
  };
}
