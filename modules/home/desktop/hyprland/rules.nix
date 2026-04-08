{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
# Define permissions, layer rules, and window rules.
let
  inherit
    (lib)
    escapeRegex
    getExe
    getExe'
    ;
in {
  wayland.windowManager.hyprland.settings = {
    # Permission settings.
    permission = let
      hyprctl = getExe' osConfig.programs.hyprland.package "hyprctl";

      xdg-desktop-portal-hyprland = getExe' osConfig.programs.hyprland.portalPackage ".xdg-desktop-portal-hyprland-wrapped";
      grim = getExe pkgs.grim;
      hyprpicker = getExe pkgs.hyprpicker;
      equibop = getExe config.programs.nixcord.equibop.package;
      quickshell = getExe' config.programs.quickshell.package ".quickshell-wrapped";
    in [
      # Allow plugin loading.
      "${escapeRegex hyprctl}, plugin, allow"

      # Allow screencopy.
      "${escapeRegex xdg-desktop-portal-hyprland}, screencopy, allow"
      "${escapeRegex grim}, screencopy, allow"
      "${escapeRegex hyprpicker}, screencopy, allow"
      "${escapeRegex quickshell}, screencopy, allow"
      "${escapeRegex equibop}, screencopy, allow"
    ];

    # Rules for layers and overlays.
    layerrule = [
      # Noanim.
      "match:namespace hyprpicker, tag +noanim"
      "match:namespace selection, tag +noanim"
      "match:namespace noctalia.+, tag +noanim"

      # Tag layers by namespace.
      "match:namespace noctalia-background-.*$, tag +blur"
      "match:namespace overzicht, tag +blur"

      # Apply behaviors by tag.
      "match:tag blur, ignore_alpha 0.94"
      "match:tag blur, blur on"
      "match:tag blur, blur_popups on"

      "match:tag noanim, no_anim on"
    ];

    windowrule = [
      # Tag windows by application.
      "match:class Aseprite, tag +tile"

      "match:class BeeperTexts, match:title Settings, tag +float"
      "match:class BeeperTexts, match:title Settings, tag +size-beeper-settings"
      "match:class BeeperTexts, no_initial_focus on"

      "match:class com.mitchellh.ghostty, tag +forceopacity"

      "match:class org.pwmt.zathura, tag +forceopacity"

      "match:class com.mitchellh.ghostty, match:title Wiremix, tag +pseudotile"
      "match:class com.mitchellh.ghostty, match:title Wiremix, tag +size-wiremix"

      "match:class equibop, tag +forceopacity"
      "match:class equibop, tag +noblur"

      "match:class file-.+, tag +float"
      "match:class file-.+, match:title Export Image as .+, tag +size-file-export"

      "match:class io.mrarm.mcpelauncher-ui-qt, tag +tile"

      "match:class me.iepure.devtoolbox, tag +float"
      "match:class me.iepure.devtoolbox, tag +center"
      "match:class me.iepure.devtoolbox, tag +size-devtoolbox"

      "match:class org.freedesktop.impl.portal.desktop.kde, tag +float"

      "match:class org.gnome.Calculator, tag +float"
      "match:class org.gnome.Calculator, tag +center"
      "match:class org.gnome.Calculator, tag +size-calculator"

      "match:class org.gnome.Decibels, tag +float"
      "match:class org.gnome.Decibels, tag +center"
      "match:class org.gnome.Decibels, tag +size-decibels"

      "match:class org.gnome.seahorse.Application, match:title .+ — Private key, tag +size-seahorse-key"
      "match:class org.gnome.seahorse.Application, match:title Item Properties, tag +size-seahorse-item"

      "match:class .protonvpn-app-wrapped, match:title Proton VPN, tag +size-protonvpn"

      "match:class steam, match:title Friends List, tag +float"
      "match:class steam, match:title Steam Settings, tag +float"
      "match:class steam, match:title Friends List, tag +size-steam-friends"

      "match:class steam_app_.*, tag +forceopacity"
      "match:class steam_app_.+, tag +noblur"

      "match:title Task Manager - .+, tag +float"
      "match:title Task Manager - .+, tag +size-task-manager"

      "match:class zen(-beta)?, match:title Bitwarden, tag +float"
      "match:title [Pp]icture[ -]in[ -][Pp]icture, tag +float"
      "match:title [Pp]icture[ -]in[ -][Pp]icture, tag +pin"
      "match:class zen(-beta)?, match:title Bitwarden, tag +size-bitwarden"

      # Apply behaviors by tag.
      "match:tag forceopacity, opacity 1 override 1 override"
      "match:tag noblur, no_blur on"
      "match:tag tile, tile on"
      "match:tag float, float on"
      "match:tag pseudotile, pseudo on"
      "match:tag pin, pin on"
      "match:tag center, center on"

      # Apply sizes by tag.
      "match:tag size-calculator, size 695 800"
      "match:tag size-task-manager, size 800 600"
      "match:tag size-steam-friends, size 380 540"
      "match:tag size-beeper-settings, size 900 900"
      "match:tag size-bitwarden, size 450 800"
      "match:tag size-protonvpn, size 400 600"
      "match:tag size-seahorse-key, size 568 720"
      "match:tag size-seahorse-item, size 400 520"
      "match:tag size-devtoolbox, size 1130 750"
      "match:tag size-file-export, size 670 513"
      "match:tag size-wiremix, size 1000 630"
      "match:tag size-decibels, size 720 500"
    ];
  };
}
