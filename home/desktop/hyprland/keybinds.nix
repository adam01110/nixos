{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

with lib;
let
  notify-send = "${getExe' pkgs.libnotify "notify-send"}";
  hyprctl = "${getExe' inputs.hyprland.packages.${system}.hyprland "hyprctl"}";
  awk = "${getExe pkgs.gawk}";
  print = "${getExe' pkgs.bash "print"}";
  ghostty = "${getExe pkgs.ghostty}";
  dolphin = "${getExe pkgs.kdePackages.dolphin}";
  equibop = "${getExe pkgs.equibop}";
  steam = "${getExe pkgs.steam}";
  zen-browser = "${getExe inputs.zen-browser.packages."${system}".default}";
  noctaliaIpc = "${getExe pkgs.quickshell} -c noctalia-shell ipc call";

  cfgFunc = config.hyprland.func.enable;

  screenshotDir = "${xdg.userDirs.pictures}/screenshot";

  performantMode = pkgs.writeShellApplication {
    name = "performantMode";
    runtimeInputs = with pkgs; [
      libnotify
      gawk
      bash
    ];
    text = ''
      HYPRGAMEMODE=$(${hyprctl} getoption animations:enabled | ${awk} 'NR==1{${print} $2}')
      if [ "$HYPRGAMEMODE" = 1 ]; then
        ${hyprctl} --batch "\
          keyword animations:enabled 0;\
          keyword decoration:shadow:enabled 0;\
          keyword decoration:blur:enabled 0;\
          keyword general:gaps_in 0;\
          keyword general:gaps_out 0;\
          keyword general:border_size 1;\
          keyword decoration:rounding 0;\
          keyword decoration:active_opacity 1;\
          keyword decoration:inactive_opacity 1"

        ${hyprctl} keyword "windowrule opacity 1 override 1 override 1 override, ^(.*)$"
        ${notify-send} -u low -a "hyprland" " performant mode" "enabled"
        exit
      else
        ${notify-send} -u low -a "hyprland" " performant mode" "disabled"
        ${hyprctl} reload
      fi
    '';
  };
in
{
  options.hyprland.func.enable = mkEnableOption "Enable function-row (F-keys) and media keybindings.";

  programs.hyprshot.enable = true;

  wayland.windowManager.hyprland.settings = {
    binds.movefocus_cycles_fullscreen = true;

    bind = [
      # workspaces
      "SUPER, 1, split:workspace, 1"
      "SUPER, 2, split:workspace, 2"
      "SUPER, 3, split:workspace, 3"
      "SUPER, 4, split:workspace, 4"
      "SUPER, 5, split:workspace, 5"
      "SUPER, 6, split:workspace, 6"
      "SUPER, 7, split:workspace, 7"
      "SUPER, 8, split:workspace, 8"
      "SUPER, 9, split:workspace, 9"

      "SUPER SHIFT, 1, split:movetoworkspace, 1"
      "SUPER SHIFT, 2, split:movetoworkspace, 2"
      "SUPER SHIFT, 3, split:movetoworkspace, 3"
      "SUPER SHIFT, 4, split:movetoworkspace, 4"
      "SUPER SHIFT, 5, split:movetoworkspace, 5"
      "SUPER SHIFT, 6, split:movetoworkspace, 6"
      "SUPER SHIFT, 7, split:movetoworkspace, 7"
      "SUPER SHIFT, 8, split:movetoworkspace, 8"
      "SUPER SHIFT, 9, split:movetoworkspace, 9"

      "SUPER CTRL, 1, split:movetoworkspacesilent, 1"
      "SUPER CTRL, 2, split:movetoworkspacesilent, 2"
      "SUPER CTRL, 3, split:movetoworkspacesilent, 3"
      "SUPER CTRL, 4, split:movetoworkspacesilent, 4"
      "SUPER CTRL, 5, split:movetoworkspacesilent, 5"
      "SUPER CTRL, 6, split:movetoworkspacesilent, 6"
      "SUPER CTRL, 7, split:movetoworkspacesilent, 7"
      "SUPER CTRL, 8, split:movetoworkspacesilent, 8"
      "SUPER CTRL, 9, split:movetoworkspacesilent, 9"

      "SUPER SHIFT, O, split:grabroguewindows"

      # window manipulation
      "SUPER SHIFT, LEFT, movewindow, l"
      "SUPER SHIFT, RIGHT, movewindow, r"
      "SUPER SHIFT, UP, movewindow, u"
      "SUPER SHIFT, DOWN, movewindow, d"

      "SUPER SHIFT, H, movewindow, l"
      "SUPER SHIFT, L, movewindow, r"
      "SUPER SHIFT, K, movewindow, u"
      "SUPER SHIFT, J, movewindow, d"

      "SUPER CTRL, LEFT, resizeactive, -20 0"
      "SUPER CTRL, RIGHT, resizeactive, 20 0"
      "SUPER CTRL, UP, resizeactive, 0 -20"
      "SUPER CTRL, DOWN, resizeactive, 0 20"

      "SUPER CTRL, H, resizeactive, -20 0"
      "SUPER CTRL, L, resizeactive, 20 0"
      "SUPER CTRL, K, resizeactive, 0 -20"
      "SUPER CTRL, J, resizeactive, 0 20"

      "SUPER, F, fullscreen"
      "SUPER, V, togglefloating"
      "SUPER, S, togglesplit"
      "SUPER, Q, killactive"

      # window focus
      "SUPER, LEFT, movefocus, l"
      "SUPER, RIGHT, movefocus, r"
      "SUPER, UP, movefocus, u"
      "SUPER, DOWN, movefocus, d"

      "SUPER, H, movefocus, l"
      "SUPER, L, movefocus, r"
      "SUPER, K, movefocus, u"
      "SUPER, J, movefocus, d"

      # miscellaneous
      "SUPER, F1, exec, ${getExe performantMode}"
      "SUPER SHIFT, TAB, hyprexpo:expo, toggle"

      # zoom
      "SUPER, mouse_down, exec, ${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${awk} '/^float.*/ {${print} $2 * 1.1}')"
      "SUPER, mouse_up, exec, ${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${awk} '/^float.*/ {${print} $2 * 0.9}')"

      "SUPER SHIFT, mouse_down, exec, ${hyprctl} -q keyword cursor:zoom_factor 1"
      "SUPER SHIFT, minus, exec, ${hyprctl} -q keyword cursor:zoom_factor 1"

      # shell
      "SUPER, tab, exec, ${noctaliaIpc} launcher toggle"
      "SUPER, P, exec, ${noctaliaIpc} sessionMenu toggle"
      "SUPER, C, exec, ${noctaliaIpc} wallpaper toggle"
      "SUPER, O, exec, ${noctaliaIpc} notifications toggleHistory"
      "SUPER, I, exec, ${noctaliaIpc} controlCenter toggle"
      "SUPER, G, exec, ${noctaliaIpc} launcher calculator"
      "SUPER, H, exec, ${noctaliaIpc} launcher clipboard"
      "SUPER, L, exec, ${noctaliaIpc} idleInhibitor toggle"

      # screenshots
      "SUPER SHIFT, S, exec, hyprshot -m region -z -o ${screenshotDir}/region"
      "SUPER, Print, exec, hyprshot -m output -c -o ${screenshotDir}/output"

      # picker
      "SUPER SHIFT, S, exec, hyprpicker -n -a -r -q -l; notify-send 'Hyprland' 'copied to clipboard'"

      # applications
      "SUPER, Return, exec, app2unit -- ${ghostty}"
      "SUPER, E, exec, app2unit -- ${dolphin}"
      "SUPER, N, exec, app2unit -- ${equibop}"
      "SUPER, B, exec, app2unit -- ${zen-browser}"
      "SUPER, M, exec, app2unit -- ${steam}"
    ];

    bindm = [
      # window manipulation
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    binde = [
      # zoom
      "SUPER, equal, exec, ${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${awk} '/^float.*/ {${print} $2 * 1.1}')"
      "minus, exec, ${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${awk} '/^float.*/ {${print} $2 * 0.9}')"
    ];
  };

  config = mkIf cfgFunc {
    wayland.windowManager.hyprland.settings.bindel = [
      # audio
      "XF86MonBrightnessUp, exec, brightnessctl set 1%+"
      "XF86MonBrightnessDown, exec, brightnessctl set 1%-"
      # brightness
      "XF86AudioMute, exec, ${noctaliaIpc} volume muteOutput"
      "XF86AudioRaiseVolume, exec, ${noctaliaIpc} volume increase"
      "XF86AudioLowerVolume, exec, ${noctaliaIpc} volume decrease"
    ];
  };
}
