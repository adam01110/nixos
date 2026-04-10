{
  # keep-sorted start
  config,
  lib,
  pkgs,
  # keep-sorted end
  ...
}:
# Manage autostart desktop entries.
let
  inherit
    (lib)
    # keep-sorted start
    getExe
    getExe'
    # keep-sorted end
    ;
  inherit
    (pkgs)
    # keep-sorted start
    makeDesktopItem
    writeShellScriptBin
    # keep-sorted end
    ;

  # keep-sorted start block=yes newline_separated=yes
  beeperAutostart = makeDesktopItem {
    name = "beeper-autostart";
    desktopName = "Beeper";
    icon = "beepertexts";

    exec = getExe (writeShellScriptBin "beeper-autostart" ''
      sleep 4
      exec ${getExe' pkgs.nur.repos.forkprince.beeper-nightly "beeper"} --no-sandbox
    '');
    startupWMClass = "Beeper";

    categories = [
      # keep-sorted start
      "Chat"
      "InstantMessaging"
      "Network"
      # keep-sorted end
    ];
  };

  equibopAutostart = makeDesktopItem {
    name = "equibop-autostart";
    desktopName = "Equibop";
    icon = "equibop";

    exec = "${getExe config.programs.nixcord.equibop.package} --start-minimized";
    startupWMClass = "Equibop";

    categories = [
      # keep-sorted start
      "Chat"
      "InstantMessaging"
      "Network"
      # keep-sorted end
    ];
  };
  # keep-sorted end
in {
  xdg.autostart = {
    enable = true;

    # Start essential background apps on login.
    entries = [
      # keep-sorted start
      "${beeperAutostart}/share/applications/beeper-autostart.desktop"
      "${equibopAutostart}/share/applications/equibop-autostart.desktop"
      # keep-sorted end
    ];
  };
}
