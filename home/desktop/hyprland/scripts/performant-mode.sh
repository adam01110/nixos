#!@bash@

HYPRPERFORMANTMODE=$(@hyprctl@ getoption animations:enabled | @gawk@ 'NR==1{print $2}')
if [ "$HYPRPERFORMANTMODE" = 1 ]; then
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

  @hyprctl@ keyword "windowrule opacity 1 override 1 override 1 override, ^(.*)$"
  @notifySend@ -u low -a "hyprland" " performant mode" "enabled"
  exit
else
  @notifySend@ -u low -a "hyprland" " performant mode" "disabled"
  @hyprctl@ reload
fi
