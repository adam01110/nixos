{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  xdg-desktop-portal-hyprland = "${getExe pkgs.xdg-desktop-portal-hyprland}";
  hyprpicker = "${getExe pkgs.hyprpicker}";
  equibop = "${getExe pkgs.equibop}";
  quickshell = "${getExe pkgs.quickshell}";

  cfgOverview = config.hyprland.overview;

  steamFriends = config.sops.secrets.steam_friends;
in
{
  sops.secrets.steam_friends = { };

  wayland.windowManager.hyprland.settings = {
    permission = [
      "${xdg-desktop-portal-hyprland}, screencopy, allow"
      "${hyprpicker}, screencopy, allow"
      "${equibop}, screencopy, allow"
    ]
    ++ optionals (cfgOverview == quickshell) [ "${quickshell}, screencopy, allow" ];

    layerrule = [
      "noanim, ^hyprpicker$"
      "noanim, ^selection$"
      "noanim, ^noctalia.*$"

      "ignorealpha 0.9, ^noctalia.*$"

      "blur, noctalia-dock-main"
      "blur, noctalia-dock-peek"
    ];

    windowrule = [
      "opacity 1 override 1 override, class:^(ghostty)$"
      "opacity 1 override 1 override, class:^(equibop)$"
      "opacity 1 override 1 override, class:^(steam_app_.*)$"

      "noblur, class:^(equibop)$"
      "noblur, class:^(steam_app_.*)$"

      "tile, class:^(io.mrarm.mcpelauncher-ui-qt)$"

      "float, class:^(org.kde.kcalc)$"
      "float, title:^(Task Manager - Helium)$"
      "float, class:^(BeeperTexts)$, title:^(Settings)$"
      "float, class:^(steam)$, title:^(Friends List)$"
      "float, class:^(steam)$, title:^(Steam Settings)$"
      "float, class:^(steam)$, title:^(${steamFriends})( [0-9]+ Chats)?$"
      "float, class:^(zen)$, title:^(Picture-in-Picture)$"
      "float, class:^(zen)$, title:^(Bitwarden)$"
      "float, class:^(me.iepure.devtoolbox)$"
      "float, class:^(org.freedesktop.impl.portal.desktop.kde)$"

      "size 380 520, class:^(org.kde.kcalc)$"
      "size 800 600, title:^(Task Manager - Helium)$"
      "size 380 540, steam:^(steam)$, title:^(Friends List)$"
      "size 900 900, class:^(BeeperTexts)$, title:^(Settings)$"
      "size 450 800, class:^(zen)$, title:^(Bitwarden)$"
      "size 400 600, class:^(protonvpn-app)$, title:^(Proton VPN)$"
      "size 568 720, class:^(org.gnome.seahorse.Application)$, title:^(.+ — Private key)$"
      "size 400 520, class:^(org.gnome.seahorse.Application)$, title:^(Item Properties)$"

      "pin, class:^(zen)$, title:^(Picture-in-Picture)$"
    ];
  };
}
