{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

let
  inherit (lib)
    escapeRegex
    getExe
    getExe'
    ;
in
{
  wayland.windowManager.hyprland.settings = {
    permission =
      let
        hyprctl = getExe' inputs.hyprland.packages.${system}.hyprland "hyprctl";

        xdg-desktop-portal-hyprland =
          getExe' inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland
            ".xdg-desktop-portal-hyprland-wrapped";
        grim = getExe pkgs.grim;
        hyprpicker = getExe pkgs.hyprpicker;
        equibop = getExe pkgs.equibop;
        quickshell = getExe' config.programs.quickshell.package ".quickshell-wrapped";
      in
      [
        "${escapeRegex hyprctl}, plugin, allow"

        "${escapeRegex xdg-desktop-portal-hyprland}, screencopy, allow"
        "${escapeRegex grim}, screencopy, allow"
        "${escapeRegex hyprpicker}, screencopy, allow"
        "${escapeRegex quickshell}, screencopy, allow"
        "${escapeRegex equibop}, screencopy, allow"
      ];

    layerrule = [
      "noanim, ^hyprpicker$"
      "noanim, ^selection$"
      "noanim, ^noctalia.*$"

      "ignorealpha 0.9, ^noctalia-dock.*$"
      "blur, noctalia-dock.*"
    ];

    windowrule = [
      "opacity 1 override 1 override, class:^(com.mitchellh.ghostty)$"
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
