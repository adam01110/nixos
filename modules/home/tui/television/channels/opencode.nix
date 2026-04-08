{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe getExe';

  opencode = getExe' config.programs.opencode.package "opencode";

  jq = getExe pkgs.jq;
  bash = getExe pkgs.bash;
in {
  programs.television.channels.opencode = {
    metadata = {
      name = "opencode";
      description = "Browse and resume OpenCode sessions";
      requirements = ["opencode" "jq"];
    };

    source = {
      command = ''
        ${opencode} session list --format json \
          | ${jq} -r '.[] | "\(.id)\t\(.title)\t\(.directory)"'
      '';

      display = "{split:\t:1}  ({split:\t:2})";
      output = "{split:\t:0}";
    };

    preview.command = ''
      ${opencode} session list --format json \
        | ${jq} -r '.[]
          | select(.id == "{split:\t:0}")
          | "TITLE:     \(.title)\nID:        \(.id)\nPROJECT:   \(.projectId)\nDIRECTORY: \(.directory)\nUPDATED:   \((.updated / 1000) | strftime(\"%Y-%m-%d %H:%M:%S\"))"
        '
    '';

    ui.preview_panel = {
      size = 60;
      header = "Session: {split:\t:1}";
    };

    keybindings = {
      enter = "actions:resume";
      ctrl-d = "actions:delete";
    };

    actions = {
      resume = {
        description = "Resume session";
        command = "${opencode} -s {split:\t:0}";
        mode = "execute";
      };

      delete = {
        description = "Delete session";
        command = ''
          ${bash} -c 'echo "Delete {split:\t:1}?" \
            && read -p "[y/N]: " conf \
            && [[ $conf == "y" ]] \
            && ${opencode} session delete {split:\t:0}'
        '';
        mode = "execute";
      };
    };
  };
}
