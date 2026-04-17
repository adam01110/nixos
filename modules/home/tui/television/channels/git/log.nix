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
  programs.television.channels.git-log = {
    # keep-sorted start block=yes newline_separated=yes
    actions = {
      # keep-sorted start block=yes newline_separated=yes
      checkout = {
        description = "Checkout the selected commit";
        command = "${git} checkout '{strip_ansi|split: :1}'";
        mode = "execute";
      };

      cherry-pick = {
        description = "Cherry-pick the selected commit";
        command = "${git} cherry-pick '{strip_ansi|split: :1}'";
        mode = "execute";
      };

      revert = {
        description = "Revert the selected commit";
        command = "${git} revert '{strip_ansi|split: :1}'";
        mode = "execute";
      };
      # keep-sorted end
    };

    keybindings = {
      # keep-sorted start
      ctrl-o = "actions:checkout";
      ctrl-r = "actions:revert";
      ctrl-y = "actions:cherry-pick";
      # keep-sorted end
    };

    metadata = {
      name = "git-log";
      description = "A channel to select from git log entries";
      requirements = [
        # keep-sorted start
        "delta"
        "git"
        # keep-sorted end
      ];
    };

    preview.command = "${git} --no-pager show --stat --color=always '{strip_ansi|split: :1}' | head -n 1000";

    source = {
      # keep-sorted start block=yes newline_separated=yes
      ansi = true;

      command = "${git} log --graph --pretty=format:'%C(yellow)%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --color=always";

      frecency = false;

      no_sort = true;

      output = "{strip_ansi|split: :1}";
      # keep-sorted end
    };
    # keep-sorted end
  };
}
