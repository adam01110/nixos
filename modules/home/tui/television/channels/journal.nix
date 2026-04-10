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

  # keep-sorted start
  journalctl = getExe' pkgs.systemd "journalctl";
  less = getExe' pkgs.less "less";
  sort = getExe' pkgs.coreutils "sort";
  # keep-sorted end
in {
  programs.television.channels.journal = {
    # keep-sorted start block=yes newline_separated=yes
    actions = {
      # keep-sorted start block=yes newline_separated=yes
      full = {
        description = "View all logs for the selected identifier in a pager";
        command = "${journalctl} -b --no-pager -o short-iso SYSLOG_IDENTIFIER='{}' | ${less}";
        mode = "fork";
      };

      logs = {
        description = "Follow live logs for the selected identifier";
        command = "${journalctl} -f SYSLOG_IDENTIFIER='{}'";
        mode = "execute";
      };
      # keep-sorted end
    };

    metadata = {
      name = "journal";
      description = "Browse systemd journal log identifiers and their logs";
      requirements = [
        # keep-sorted start
        "bat"
        "journalctl"
        # keep-sorted end
      ];
    };

    preview.command = "${getExe (writeShellApplication {
      name = "tv-journal-preview";
      runtimeInputs = [
        # keep-sorted start
        config.programs.bat.package
        pkgs.systemd
        # keep-sorted end
      ];
      text = ''
        journalctl -b --no-pager -o short-iso -n 50 "SYSLOG_IDENTIFIER=$1" 2>/dev/null \
          | bat --language=syslog --theme=ansi --style=plain --color=always
      '';
    })} '{}'";

    source.command = "${journalctl} --field SYSLOG_IDENTIFIER 2>/dev/null | ${sort} -f";

    ui.preview_panel.size = 70;
    # keep-sorted end
  };
}
