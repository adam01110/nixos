{
  osConfig,
  lib,
  ...
}: let
  inherit
    (lib)
    getExe
    getExe'
    ;

  sudo = getExe osConfig.security.sudo-rs.package;
  systemctl = getExe' osConfig.systemd.package "systemctl";
in {
  programs.television.channels.units = {
    metadata = {
      name = "units";
      description = "List and manage systemd services";
      requirements = ["systemctl"];
    };

    source = {
      command = [
        "${systemctl} list-units --type=service --no-pager --no-legend --plain"
        "${systemctl} list-units --type=service --all --no-pager --no-legend --plain"
      ];
      display = "{split: :0}";
    };

    # Force ANSI colors because television preview runs without a tty.
    preview.command = "SYSTEMD_COLORS=1 ${systemctl} status '{split: :0}' --no-pager";

    keybindings = {
      ctrl-s = "actions:start";
      f2 = "actions:stop";
      ctrl-r = "actions:restart";
      ctrl-e = "actions:enable";
      ctrl-d = "actions:disable";
    };

    actions = {
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

      restart = {
        description = "Restart the selected service";
        command = "${sudo} ${systemctl} restart '{split: :0}'";
        mode = "execute";
      };

      enable = {
        description = "Enable the selected service";
        command = "${sudo} ${systemctl} enable '{split: :0}'";
        mode = "execute";
      };

      disable = {
        description = "Disable the selected service";
        command = "${sudo} ${systemctl} disable '{split: :0}'";
        mode = "execute";
      };
    };
  };
}
