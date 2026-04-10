{
  # keep-sorted start
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

  # keep-sorted start
  awk = getExe pkgs.gawk;
  kill = getExe' pkgs.coreutils "kill";
  procs = getExe pkgs.procs;
  ps = getExe' pkgs.procps "ps";
  # keep-sorted end
in {
  programs.television.channels.procs = {
    # keep-sorted start block=yes newline_separated=yes
    actions = {
      # keep-sorted start block=yes newline_separated=yes
      cont = {
        description = "Continue or resume the selected process (SIGCONT)";
        command = "${kill} -CONT {split: :0}";
        mode = "fork";
      };

      kill = {
        description = "Kill the selected process (SIGKILL)";
        command = "${kill} -9 {split: :0}";
        mode = "execute";
      };

      stop = {
        description = "Stop or pause the selected process (SIGSTOP)";
        command = "${kill} -STOP {split: :0}";
        mode = "fork";
      };

      term = {
        description = "Terminate the selected process (SIGTERM)";
        command = "${kill} -15 {split: :0}";
        mode = "execute";
      };
      # keep-sorted end
    };

    keybindings = {
      # keep-sorted start
      ctrl-c = "actions:cont";
      ctrl-k = "actions:kill";
      ctrl-s = "actions:stop";
      f2 = "actions:term";
      # keep-sorted end
    };

    metadata = {
      name = "procs";
      description = "Find and manage running processes";
      requirements = [
        # keep-sorted start
        "awk"
        "procs"
        "ps"
        # keep-sorted end
      ];
    };

    preview.command = "${procs} --color=always --tree --pager=always '{split: :0}'";

    source = {
      # keep-sorted start
      command = "${ps} -e -o pid=,ucomm= | ${awk} '{print $1, $2}'";
      display = "{split: :1}";
      output = "{split: :0}";
      # keep-sorted end
    };
    # keep-sorted end
  };
}
