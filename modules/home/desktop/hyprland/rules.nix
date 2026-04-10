{
  # keep-sorted start
  config,
  lib,
  osConfig,
  pkgs,
  # keep-sorted end
  ...
}:
# Define permissions, layer rules, and window rules.
let
  inherit
    (lib)
    # keep-sorted start
    escapeRegex
    getExe
    getExe'
    # keep-sorted end
    ;
in {
  wayland.windowManager.hyprland.settings = {
    # keep-sorted start block=yes newline_separated=yes
    # Permission settings.
    permission = let
      # keep-sorted start
      equibop = getExe config.programs.nixcord.equibop.package;
      grim = getExe pkgs.grim;
      hyprctl = getExe' osConfig.programs.hyprland.package "hyprctl";
      hyprpicker = getExe pkgs.hyprpicker;
      quickshell = getExe' config.programs.quickshell.package ".quickshell-wrapped";
      xdg-desktop-portal-hyprland = getExe' osConfig.programs.hyprland.portalPackage ".xdg-desktop-portal-hyprland-wrapped";
      # keep-sorted end
    in [
      # Allow plugin loading.
      "${escapeRegex hyprctl}, plugin, allow"

      # Allow screencopy.
      # keep-sorted start
      "${escapeRegex equibop}, screencopy, allow"
      "${escapeRegex grim}, screencopy, allow"
      "${escapeRegex hyprpicker}, screencopy, allow"
      "${escapeRegex quickshell}, screencopy, allow"
      "${escapeRegex xdg-desktop-portal-hyprland}, screencopy, allow"
      # keep-sorted end
    ];

    # Rules for layers and overlays.
    layerrule = [
      # Noanim.
      # keep-sorted start
      "match:namespace hyprpicker, tag +noanim"
      "match:namespace noctalia.+, tag +noanim"
      "match:namespace selection, tag +noanim"
      # keep-sorted end

      # Tag layers by namespace.
      # keep-sorted start
      "match:namespace noctalia-background-.*$, tag +blur"
      "match:namespace overzicht, tag +blur"
      # keep-sorted end

      # Apply behaviors by tag.
      # keep-sorted start
      "match:tag blur, blur on"
      "match:tag blur, blur_popups on"
      "match:tag blur, ignore_alpha 0.94"
      # keep-sorted end

      "match:tag noanim, no_anim on"
    ];

    windowrule = [
      # Tag windows by application.
      "match:class Aseprite, tag +tile"

      # keep-sorted start
      "match:class BeeperTexts, match:title Settings, tag +float"
      "match:class BeeperTexts, match:title Settings, tag +size-beeper-settings"
      "match:class BeeperTexts, no_initial_focus on"
      # keep-sorted end

      "match:class com.mitchellh.ghostty, tag +forceopacity"

      "match:class org.pwmt.zathura, tag +forceopacity"

      # keep-sorted start
      "match:class com.mitchellh.ghostty, match:title Wiremix, tag +pseudotile"
      "match:class com.mitchellh.ghostty, match:title Wiremix, tag +size-wiremix"
      # keep-sorted end

      # keep-sorted start
      "match:class equibop, tag +forceopacity"
      "match:class equibop, tag +noblur"
      # keep-sorted end

      # keep-sorted start
      "match:class file-.+, match:title Export Image as .+, tag +size-file-export"
      "match:class file-.+, tag +float"
      # keep-sorted end

      "match:class io.mrarm.mcpelauncher-ui-qt, tag +tile"

      # keep-sorted start
      "match:class me.iepure.devtoolbox, tag +center"
      "match:class me.iepure.devtoolbox, tag +float"
      "match:class me.iepure.devtoolbox, tag +size-devtoolbox"
      # keep-sorted end

      "match:class org.freedesktop.impl.portal.desktop.kde, tag +float"

      # keep-sorted start
      "match:class org.gnome.Calculator, tag +center"
      "match:class org.gnome.Calculator, tag +float"
      "match:class org.gnome.Calculator, tag +size-calculator"
      # keep-sorted end

      # keep-sorted start
      "match:class org.gnome.Decibels, tag +center"
      "match:class org.gnome.Decibels, tag +float"
      "match:class org.gnome.Decibels, tag +size-decibels"
      # keep-sorted end

      # keep-sorted start
      "match:class org.gnome.seahorse.Application, match:title .+ — Private key, tag +size-seahorse-key"
      "match:class org.gnome.seahorse.Application, match:title Item Properties, tag +size-seahorse-item"
      # keep-sorted end

      "match:class .protonvpn-app-wrapped, match:title Proton VPN, tag +size-protonvpn"

      # keep-sorted start
      "match:class steam, match:title Friends List, tag +float"
      "match:class steam, match:title Friends List, tag +size-steam-friends"
      "match:class steam, match:title Steam Settings, tag +float"
      # keep-sorted end

      # keep-sorted start
      "match:class steam_app_.*, tag +forceopacity"
      "match:class steam_app_.+, tag +noblur"
      # keep-sorted end

      # keep-sorted start
      "match:title Task Manager - .+, tag +float"
      "match:title Task Manager - .+, tag +size-task-manager"
      # keep-sorted end

      # keep-sorted start
      "match:class zen(-beta)?, match:title Bitwarden, tag +float"
      "match:class zen(-beta)?, match:title Bitwarden, tag +size-bitwarden"
      "match:title [Pp]icture[ -]in[ -][Pp]icture, tag +float"
      "match:title [Pp]icture[ -]in[ -][Pp]icture, tag +pin"
      # keep-sorted end

      # Apply behaviors by tag.
      # keep-sorted start
      "match:tag center, center on"
      "match:tag float, float on"
      "match:tag forceopacity, opacity 1 override 1 override"
      "match:tag noblur, no_blur on"
      "match:tag pin, pin on"
      "match:tag pseudotile, pseudo on"
      "match:tag tile, tile on"
      # keep-sorted end

      # Apply sizes by tag.
      # keep-sorted start
      "match:tag size-beeper-settings, size 900 900"
      "match:tag size-bitwarden, size 450 800"
      "match:tag size-calculator, size 695 800"
      "match:tag size-decibels, size 720 500"
      "match:tag size-devtoolbox, size 1130 750"
      "match:tag size-file-export, size 670 513"
      "match:tag size-protonvpn, size 400 600"
      "match:tag size-seahorse-item, size 400 520"
      "match:tag size-seahorse-key, size 568 720"
      "match:tag size-steam-friends, size 380 540"
      "match:tag size-task-manager, size 800 600"
      "match:tag size-wiremix, size 1000 630"
      # keep-sorted end
    ];
    # keep-sorted end
  };
}
