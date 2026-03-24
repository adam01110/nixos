{
  pkgs,
  lib,
  ...
}: let
  inherit
    (lib)
    getExe
    getExe'
    ;

  awk = getExe pkgs.gawk;
  kill = getExe' pkgs.coreutils "kill";
  procs = getExe pkgs.procs;
  ps = getExe' pkgs.procps "ps";
in {
  programs.television.channels.procs = {
    metadata = {
      name = "procs";
      description = "Find and manage running processes";
      requirements = [
        "ps"
        "awk"
        "procs"
      ];
    };

    source = {
      command = "${ps} -e -o pid=,ucomm= | ${awk} '{print $1, $2}'";
      display = "{split: :1}";
      output = "{split: :0}";
    };

    preview.command = "${procs} --color=always --tree --pager=always '{split: :0}'";

    keybindings = {
      ctrl-k = "actions:kill";
      f2 = "actions:term";
      ctrl-s = "actions:stop";
      ctrl-c = "actions:cont";
    };

    actions = {
      kill = {
        description = "Kill the selected process (SIGKILL)";
        command = "${kill} -9 {split: :0}";
        mode = "execute";
      };

      term = {
        description = "Terminate the selected process (SIGTERM)";
        command = "${kill} -15 {split: :0}";
        mode = "execute";
      };

      stop = {
        description = "Stop or pause the selected process (SIGSTOP)";
        command = "${kill} -STOP {split: :0}";
        mode = "fork";
      };

      cont = {
        description = "Continue or resume the selected process (SIGCONT)";
        command = "${kill} -CONT {split: :0}";
        mode = "fork";
      };
    };
  };
}
