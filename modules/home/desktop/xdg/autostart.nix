{
  config,
  lib,
  pkgs,
  ...
}:
# Manage autostart desktop entries.
let
  inherit (lib) getExe getExe';
  inherit
    (pkgs)
    makeDesktopItem
    writeShellScriptBin
    ;

  equibopAutostart = makeDesktopItem {
    name = "equibop-autostart";
    desktopName = "Equibop";
    exec = "${getExe config.programs.nixcord.equibop.package} --start-minimized";
    icon = "equibop";
    startupWMClass = "Equibop";
    categories = [
      "Network"
      "InstantMessaging"
      "Chat"
    ];
  };

  beeperAutostart = makeDesktopItem {
    name = "beeper-autostart";
    desktopName = "Beeper";
    exec = getExe (writeShellScriptBin "beeper-autostart" ''
      sleep 4
      exec ${getExe' pkgs.nur.repos.forkprince.beeper-nightly "beeper"} --no-sandbox
    '');
    icon = "beepertexts";
    startupWMClass = "Beeper";
    categories = [
      "Network"
      "InstantMessaging"
      "Chat"
    ];
  };
in {
  xdg.autostart = {
    enable = true;

    # Start essential background apps on login.
    entries = [
      "${equibopAutostart}/share/applications/equibop-autostart.desktop"
      "${beeperAutostart}/share/applications/beeper-autostart.desktop"
    ];
  };
}
