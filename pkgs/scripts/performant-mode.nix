/*
SPDX-License-Identifier: AGPL-3.0-or-later
*/
{pkgs}:
# Wrap the performant mode toggle script with concrete runtime paths.
pkgs.writeShellApplication {
  name = "performantMode";
  runtimeInputs = [pkgs.gawk];
  excludeShellChecks = ["SC2276"];
  text = ''
    # Read the current animations.enabled flag to infer mode state.
    HYPRPERFORMANTMODE=$(hyprctl getoption animations:enabled | gawk 'NR==1{print $2}')
    if [ "$HYPRPERFORMANTMODE" = 1 ]; then
      # Turn off visual features and tighten layout.
      SETTINGS=(
        # keep-sorted start numeric=yes
        "animations:enabled 0"
        "decoration:active_opacity 1"
        "decoration:blur:enabled 0"
        "decoration:inactive_opacity 1"
        "decoration:shadow:enabled 0"
        "general:border_size 1"
        "general:gaps_in 0"
        "general:gaps_out 0"
        "windowrule opacity 1 override 1 override 1 override, ^(.*)$"
        # keep-sorted end
      )

      BATCH_COMMANDS=$(printf 'keyword %s;' "''${SETTINGS[@]}")
      hyprctl --batch "$BATCH_COMMANDS"
      exit
    else
      # Restore normal settings by reloading hyprland.
      hyprctl reload
    fi
  '';
}
