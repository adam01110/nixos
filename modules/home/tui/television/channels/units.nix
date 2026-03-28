{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (builtins) attrValues;
  inherit
    (lib)
    getExe
    getExe'
    ;
  inherit (pkgs) writeShellApplication;

  sudo = getExe osConfig.security.sudo-rs.package;
  systemctl = getExe' osConfig.systemd.package "systemctl";
in {
  programs.television.channels.units = {
    metadata = {
      name = "units";
      description = "List and manage systemd services";
      requirements = [
        "systemctl"
        "bat"
        "sudo"
      ];
    };

    source = {
      command = [
        "${systemctl} list-units --type=service --no-pager --no-legend --plain"
        "${systemctl} list-units --type=service --all --no-pager --no-legend --plain"
      ];
      display = "{split: :0}";
    };

    # Preserve native systemd colors above the status/log separator line.
    preview.command = "${getExe (writeShellApplication {
      name = "tv-units-preview";
      runtimeInputs =
        attrValues {
          inherit
            (pkgs)
            coreutils
            gawk
            ;
        }
        ++ [
          config.programs.bat.package
          osConfig.systemd.package
        ];
      text = ''
        unit="$1"
        status="$(SYSTEMD_COLORS=1 systemctl status "$unit" --no-pager --full --lines=50)"
        sep="$(printf '%s\n' "$status" | awk '/^[[:space:]]*$/ { print NR; exit }')"

        if [ -n "$sep" ]; then
          printf '%s\n' "$status" | sed -n "1,$((sep - 1))p"

          if [ "$(printf '%s\n' "$status" | wc -l)" -gt "$sep" ]; then
            printf '\n'
            printf '%s\n' "$status" | tail -n "+$((sep + 1))" | bat --language=syslog --theme=ansi --style=plain --color=always
          fi
        else
          printf '%s\n' "$status"
        fi
      '';
    })} '{split: :0}'";

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
