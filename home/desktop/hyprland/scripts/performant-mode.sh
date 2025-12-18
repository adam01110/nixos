#!@bash@

# read the current animations.enabled flag to infer mode state.
HYPRPERFORMANTMODE=$(@hyprctl@ getoption animations:enabled | @gawk@ 'NR==1{print $2}')
if [ "$HYPRPERFORMANTMODE" = 1 ]; then
  # turn off visual features and tighten layout.
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

  BATCH_COMMANDS=$(printf 'keyword %s;' "${SETTINGS[@]}")
  @hyprctl@ --batch "$BATCH_COMMANDS"

  # notify the user about the active mode.
  @notifySend@ -u low -a "desktop" "Performant mode" "Enabled"
  exit
else
  # restore normal settings by reloading hyprland.
  @notifySend@ -u low -a "desktop" "Performant mode" "Disabled"
  @hyprctl@ reload
fi
