{
  # keep-sorted start
  config,
  lib,
  osConfig,
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
  sudo = getExe osConfig.security.sudo-rs.package;
  systemctl = getExe' osConfig.systemd.package "systemctl";
  # keep-sorted end
in {
  programs.television.channels.units = {
    # keep-sorted start block=yes newline_separated=yes
    actions = {
      # keep-sorted start block=yes newline_separated=yes
      disable = {
        description = "Disable the selected service";
        command = "${sudo} ${systemctl} disable '{split: :0}'";
        mode = "execute";
      };

      enable = {
        description = "Enable the selected service";
        command = "${sudo} ${systemctl} enable '{split: :0}'";
        mode = "execute";
      };

      restart = {
        description = "Restart the selected service";
        command = "${sudo} ${systemctl} restart '{split: :0}'";
        mode = "execute";
      };

      start = {
        description = "Start the selected service";
        command = "${sudo} ${systemctl} start '{split: :0}'";
        mode = "execute";
      };

      stop = {
        description = "Stop the selected service";
        command = "${sudo} ${systemctl} stop '{split: :0}'";
        mode = "execute";
      };
      # keep-sorted end
    };

    keybindings = {
      # keep-sorted start
      ctrl-d = "actions:disable";
      ctrl-e = "actions:enable";
      ctrl-r = "actions:restart";
      ctrl-s = "actions:start";
      f2 = "actions:stop";
      # keep-sorted end
    };

    metadata = {
      name = "units";
      description = "List and manage systemd services";
      requirements = [
        # keep-sorted start
        "bat"
        "sudo"
        "systemctl"
        # keep-sorted end
      ];
    };

    # Preserve native systemd colors above the status/log separator line.
    preview.command = "${getExe (import ../../scripts/_systemd-status-preview.nix {
      inherit
        # keep-sorted start
        config
        lib
        osConfig
        pkgs
        # keep-sorted end
        ;
    })} '{split: :0}'";

    source = {
      # keep-sorted start block=yes newline_separated=yes
      command = [
        "${systemctl} list-units --type=service --no-pager --no-legend --plain"
        "${systemctl} list-units --type=service --all --no-pager --no-legend --plain"
      ];

      display = "{split: :0}";
      # keep-sorted end
    };
    # keep-sorted end
  };
}
