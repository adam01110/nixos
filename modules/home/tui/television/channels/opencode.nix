{
  # keep-sorted start
  config,
  lib,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit
    (lib)
    # keep-sorted start
    getExe
    getExe'
    # keep-sorted end
    ;
  inherit (pkgs) writeShellApplication;

  opencode = getExe' config.programs.opencode.package "opencode";
in {
  programs.television.channels.opencode = {
    metadata = {
      name = "opencode";
      description = "Browse and resume OpenCode sessions";
      requirements = [
        # keep-sorted start
        "jq"
        "opencode"
        # keep-sorted end
      ];
    };

    source = {
      command = getExe (writeShellApplication {
        name = "tv-opencode-source";
        runtimeInputs = [
          # keep-sorted start
          config.programs.opencode.package
          pkgs.jq
          # keep-sorted end
        ];
        text = ''
          opencode session list --format json \
            | jq -r '.[] | "\(.id)\t\(.title)\t\(.directory)"'
        '';
      });

      display = "{split:\t:1}  ({split:\t:2})";
      output = "{split:\t:0}";
    };

    preview.command = "${getExe (writeShellApplication {
      name = "tv-opencode-preview";
      runtimeInputs = [
        # keep-sorted start
        config.programs.opencode.package
        pkgs.jq
        # keep-sorted end
      ];
      text = ''
        session_id="$1"

        opencode session list --format json \
          | jq -r --arg session_id "$session_id" '.[]
            | select(.id == $session_id)
            | "TITLE:     \(.title)\nID:        \(.id)\nPROJECT:   \(.projectId)\nDIRECTORY: \(.directory)\nUPDATED:   \((.updated / 1000) | strftime(\"%Y-%m-%d %H:%M:%S\"))"
          '
      '';
    })} '{split:\t:0}'";

    ui.preview_panel = {
      # keep-sorted start
      header = "Session: {split:\t:1}";
      size = 60;
      # keep-sorted end
    };

    keybindings = {
      # keep-sorted start
      ctrl-d = "actions:delete";
      enter = "actions:resume";
      # keep-sorted end
    };

    actions = {
      resume = {
        description = "Resume session";
        command = "${opencode} -s {split:\t:0}";
        mode = "execute";
      };

      delete = {
        description = "Delete session";
        command = "${getExe (writeShellApplication {
          name = "tv-opencode-delete";
          runtimeInputs = [config.programs.opencode.package];
          text = ''
            session_id="$1"
            session_title="$2"

            echo "Delete $session_title?"
            read -r -p "[y/N]: " conf

            if [ "$conf" = "y" ]; then
              opencode session delete "$session_id"
            fi
          '';
        })} '{split:\t:0}' '{split:\t:1}'";
        mode = "execute";
      };
    };
  };
}
