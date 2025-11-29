#!@bash@

# read the current animations.enabled flag to infer mode state.
HYPRPERFORMANTMODE=$(@hyprctl@ getoption animations:enabled | @gawk@ 'NR==1{print $2}')
if [ "$HYPRPERFORMANTMODE" = 1 ]; then
  # turn off visual features and tighten layout.
  @hyprctl@ --batch "\
    keyword animations:enabled 0;\
    keyword decoration:shadow:enabled 0;\
    keyword decoration:blur:enabled 0;\
    keyword general:gaps_in 0;\
    keyword general:gaps_out 0;\
    keyword general:border_size 1;\
    keyword decoration:rounding 0;\
    keyword decoration:active_opacity 1;\
    keyword decoration:inactive_opacity 1"

  # make all windows fully opaque until reload.
  @hyprctl@ keyword "windowrule opacity 1 override 1 override 1 override, ^(.*)$"

  # notify the user about the active mode.
  @notifySend@ -u low -a "desktop" "Performant mode" "Enabled"
  exit
else
  # restore normal settings by reloading hyprland.
  @notifySend@ -u low -a "desktop" "Performant mode" "Disabled"
  @hyprctl@ reload
fi
