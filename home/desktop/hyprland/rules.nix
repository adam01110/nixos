{
  config,
  osConfig,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

# define permissions, layer rules, and window rules.
let
  inherit (lib)
    escapeRegex
    getExe
    getExe'
    ;
in
{
  wayland.windowManager.hyprland.settings = {
    # permission settings.
    permission =
      let
        hyprctl = getExe' osConfig.programs.hyprland.package "hyprctl";

        xdg-desktop-portal-hyprland =
          getExe' inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland
            ".xdg-desktop-portal-hyprland-wrapped";
        grim = getExe pkgs.grim;
        hyprpicker = getExe pkgs.hyprpicker;
        equibop = getExe config.programs.nixcord.equibop.package;
        quickshell = getExe' config.programs.quickshell.package ".quickshell-wrapped";
      in
      [
        # allow plugin loading
        "${escapeRegex hyprctl}, plugin, allow"

        # allow screencopy.
        "${escapeRegex xdg-desktop-portal-hyprland}, screencopy, allow"
        "${escapeRegex grim}, screencopy, allow"
        "${escapeRegex hyprpicker}, screencopy, allow"
        "${escapeRegex quickshell}, screencopy, allow"
        "${escapeRegex equibop}, screencopy, allow"
      ];

    # rules for layers and overlays.
    layerrule = [
      # noanim.
      "match:namespace hyprpicker, no_anim on"
      "match:namespace selection, no_anim on"
      "match:namespace noctalia.+, no_anim on"

      # ingoreaplha.
      "match:namespace noctalia-dock.+, ignore_alpha 0.95"
      "match:namespace noctalia-panel-content.+, ignore_alpha 0.95"

      # blur
      "match:namespace noctalia-dock.+, blur on"
      "match:namespace noctalia-panel-content.+, blur on"
    ];

    windowrule = [
      # force opacity.
      "match:class com.mitchellh.ghostty, opacity 1 override 1 override"
      "match:class equibop, opacity 1 override 1 override"
      "match:class steam_app_.*, opacity 1 override 1 override"

      # noblur.
      "match:class equibop, no_blur on"
      "match:class steam_app_.+, no_blur on"

      # tile.
      "match:class io.mrarm.mcpelauncher-ui-qt, tile on"

      # float.
      "match:class org.gnome.Calculator, float on"
      "match:title Task Manager - .+, float on"
      "match:class BeeperTexts, match:title Settings, float on"
      "match:class steam, match:title Friends List, float on"
      "match:class steam, match:title Steam Settings, float on"
      "match:class zen, match:title Picture-in-Picture, float on"
      "match:class zen, match:title Bitwarden, float on"
      "match:class me.iepure.devtoolbox, float on"
      "match:class org.freedesktop.impl.portal.desktop.kde, float on"

      # set size.
      "match:class org.gnome.Calculator, size 695 800"
      "match:title Task Manager - .+, size 800 600"
      "match:class steam, match:title Friends List, size 380 540,"
      "match:class BeeperTexts, match:title Settings, size 900 900"
      "match:class zen, match:title Bitwarden, size 450 800"
      "match:class .protonvpn-app-wrapped, match:title Proton VPN, size 400 600"
      "match:class org.gnome.seahorse.Application, match:title .+ — Private key, size 568 720"
      "match:class org.gnome.seahorse.Application, match:title Item Properties, size 400 520"
      "match:class me.iepure.devtoolbox, size 1130 750"

      # pin.
      "match:class zen, match:title Picture-in-Picture, pin on"
    ];
  };
}
