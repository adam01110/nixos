{
  lib,
  pkgs,
  osConfig,
}:
# Wrap the performant mode toggle script with concrete runtime paths.
let
  inherit (builtins) attrValues;
  inherit
    (lib)
    getExe
    getExe'
    ;

  hyprctl = getExe' osConfig.programs.hyprland.package "hyprctl";
  notify-send = getExe' pkgs.libnotify "notify-send";
  gawk = getExe pkgs.gawk;
in
  pkgs.writeShellApplication {
    name = "performantMode";
    runtimeInputs = attrValues {
      inherit
        (pkgs)
        gawk
        libnotify
        ;
    };
    excludeShellChecks = ["SC2276"];
    text = ''
      notify_enabled=1
      if [ "''${1-}" = "--no-notify" ]; then
        notify_enabled=0
      fi

      # Read the current animations.enabled flag to infer mode state.
      HYPRPERFORMANTMODE=$(${hyprctl} getoption animations:enabled | ${gawk} 'NR==1{print $2}')
      if [ "$HYPRPERFORMANTMODE" = 1 ]; then
        # Turn off visual features and tighten layout.
        SETTINGS=(
          "animations:enabled 0"
          "decoration:shadow:enabled 0"
          "decoration:blur:enabled 0"
          "general:gaps_in 0"
          "general:gaps_out 0"
          "general:border_size 1"
          "decoration:active_opacity 1"
          "decoration:inactive_opacity 1"
          "windowrule opacity 1 override 1 override 1 override, ^(.*)$"
        )

        BATCH_COMMANDS=$(printf 'keyword %s;' "''${SETTINGS[@]}")
        ${hyprctl} --batch "$BATCH_COMMANDS"

        # Notify the user about the active mode.
        if [ "$notify_enabled" = 1 ]; then
          ${notify-send} -u low -a "desktop" "Performant mode" "Enabled"
        fi
        exit
      else
        # Restore normal settings by reloading hyprland.
        if [ "$notify_enabled" = 1 ]; then
          ${notify-send} -u low -a "desktop" "Performant mode" "Disabled"
        fi
        ${hyprctl} reload
      fi
    '';
  }
