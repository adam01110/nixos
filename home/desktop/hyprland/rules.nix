{
  config,
  lib,
  pkgs,
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    permission = [
      "${pkgs.xdg-desktop-portal-hyprland}/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
    ];

    layerrule = [ ];

    windowrule = [
      "opacity 1 override 1 override, class:^(ghostty)$"

      "tile, class:^(io.mrarm.mcpelauncher-ui-qt)$"

      "float, class:^(org.kde.kcalc)$"
      "float, title:^(Task Manager - .+)$"
      "float, class:^(BeeperTexts)$, title:^(Settings)$"
      "float, steam:^(steam)$, title:^(Friends List)$"
      "float, steam:^(steam)$, title:^(Steam Settings)$"
      "float, steam:^(steam)$, title:^(Merlijn|PistAshio|poypoyman|AngelKick|akaracemonster)( [0-9]+ Chats)?$"
      "float, class:^(zen)$, title:^(Picture-in-Picture)$"
      "float, class:^(zen)$, title:(Bitwarden)"

      "size 380 520, class:^(org.kde.kcalc)$"
      "size 640 440, title:^(Task Manager - .+)$"
      "size 900 900 class:^(BeeperTexts)$, title:^(Settings)$"
      "size 450 800, class:^(zen)$, title:(Bitwarden)"
    ];
  };
}
