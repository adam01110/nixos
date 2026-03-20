{
  config,
  lib,
  pkgs,
  ...
}:
# Manage autostart desktop entries.
let
  inherit (lib) getExe;
  inherit (pkgs) makeDesktopItem;

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
in {
  xdg.autostart = {
    enable = true;

    # Start essential background apps on login.
    entries = [
      "${equibopAutostart}/share/applications/equibop-autostart.desktop"
      "${pkgs.nur.repos.forkprince.beeper-nightly}/share/applications/beepertexts.desktop"
    ];
  };
}
