{
  config,
  osConfig,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

# keybindings for hyprland including workspace, window, and media controls.
let
  inherit (lib)
    getExe
    getExe'
    mkEnableOption
    optionals
    ;
  inherit (pkgs) callPackage;
in
{
  options.hyprland.brightness.enable = mkEnableOption "Enable function-row (F-keys) for brightness keybindings.";

  # generate hyprland binding lists and helpers.
  config.wayland.windowManager.hyprland.settings =
    let
      gawk = getExe pkgs.gawk;
      hyprctl = getExe' osConfig.programs.hyprland.package "hyprctl";

      qs = getExe' config.programs.quickshell.package ".quickshell-wrapped";
      noctalia = "${getExe' config.programs.noctalia-shell.package "noctalia-shell"} ipc call";
    in
    {
      # allow focus cycling while a window is fullscreen.
      binds.movefocus_cycles_fullscreen = true;

      # define general keybindings and commands.
      bindd =
        let
          performantMode = callPackage ./scripts/performant-mode.nix { inherit osConfig; };
          thunar = getExe pkgs.xfce.thunar;
          equibop = getExe config.programs.nixcord.equibop.package;
          ghostty = "${getExe config.programs.ghostty.package} +new-window";
          hyprpicker = getExe config.programs.hyprshot.package;
          hyprshot = getExe config.programs.hyprshot.package;
          steam = getExe osConfig.programs.steam.package;
          zen-browser = getExe inputs.zen-browser.packages."${system}".default;
          app2unit = "${getExe config.programs.noctalia-shell.app2unit.package} --";

          screenshotDir = "${config.xdg.userDirs.pictures}/screenshot";
        in
        [
          # switch between numbered workspaces.
          "SUPER, 1, Switch to workspace 1, split:workspace, 1"
          "SUPER, 2, Switch to workspace 2, split:workspace, 2"
          "SUPER, 3, Switch to workspace 3, split:workspace, 3"
          "SUPER, 4, Switch to workspace 4, split:workspace, 4"
          "SUPER, 5, Switch to workspace 5, split:workspace, 5"
          "SUPER, 6, Switch to workspace 6, split:workspace, 6"
          "SUPER, 7, Switch to workspace 7, split:workspace, 7"
          "SUPER, 8, Switch to workspace 8, split:workspace, 8"

          # move the active window to a workspace.
          "SUPER SHIFT, 1, Move window to workspace 1, split:movetoworkspace, 1"
          "SUPER SHIFT, 2, Move window to workspace 2, split:movetoworkspace, 2"
          "SUPER SHIFT, 3, Move window to workspace 3, split:movetoworkspace, 3"
          "SUPER SHIFT, 4, Move window to workspace 4, split:movetoworkspace, 4"
          "SUPER SHIFT, 5, Move window to workspace 5, split:movetoworkspace, 5"
          "SUPER SHIFT, 6, Move window to workspace 6, split:movetoworkspace, 6"
          "SUPER SHIFT, 7, Move window to workspace 7, split:movetoworkspace, 7"
          "SUPER SHIFT, 8, Move window to workspace 8, split:movetoworkspace, 8"

          # silently move the active window to a workspace.
          "SUPER CTRL, 1, Silently move window to workspace 1, split:movetoworkspacesilent, 1"
          "SUPER CTRL, 2, Silently move window to workspace 2, split:movetoworkspacesilent, 2"
          "SUPER CTRL, 3, Silently move window to workspace 3, split:movetoworkspacesilent, 3"
          "SUPER CTRL, 4, Silently move window to workspace 4, split:movetoworkspacesilent, 4"
          "SUPER CTRL, 5, Silently move window to workspace 5, split:movetoworkspacesilent, 5"
          "SUPER CTRL, 6, Silently move window to workspace 6, split:movetoworkspacesilent, 6"
          "SUPER CTRL, 7, Silently move window to workspace 7, split:movetoworkspacesilent, 7"
          "SUPER CTRL, 8, Silently move window to workspace 8, split:movetoworkspacesilent, 8"

          # swap windows.
          "SUPER SHIFT, LEFT, Swap window to the left, movewindow, l"
          "SUPER SHIFT, RIGHT, Swap window to the right, movewindow, r"
          "SUPER SHIFT, UP, Swap window up, movewindow, u"
          "SUPER SHIFT, DOWN, Swap window down, movewindow, d"

          "SUPER SHIFT, H, Swap window to the left, movewindow, l"
          "SUPER SHIFT, L, Swap window to the right, movewindow, r"
          "SUPER SHIFT, K, Swap window up, movewindow, u"
          "SUPER SHIFT, J, Swap window down, movewindow, d"

          # window control.
          "SUPER, F, Fullscreen window, fullscreen"
          "SUPER, V, Toggle window floating/tiling, togglefloating"
          "SUPER, S, Toggle window split, togglesplit"
          "SUPER, P, Pseudo window, pseudo"
          "SUPER, Q, Close window, killactive"
          "SUPER SHIFT, O, Grab all windows in invalid workspaces, split:grabroguewindows"

          # window focus.
          "SUPER, LEFT, Move window focus to the left, movefocus, l"
          "SUPER, RIGHT, Move window focus to the right, movefocus, r"
          "SUPER, UP, Move window focus up, movefocus, u"
          "SUPER, DOWN, Move window focus down, movefocus, d"

          "SUPER, H, Move window focus to the left, movefocus, l"
          "SUPER, L, Move window focus to the right, movefocus, r"
          "SUPER, K, Move window focus up, movefocus, u"
          "SUPER, J, Move window focus down, movefocus, d"

          # miscellaneous.
          "SUPER SHIFT, TAB, Toggle overview, exec, ${qs} ipc -c overview call overview toggle"
          "SUPER, F1, Toggle performant mode, exec, ${getExe performantMode}"

          # zoom.
          "SUPER SHIFT, mouse_down, Reset zoom, exec, ${hyprctl} -q keyword cursor:zoom_factor 1"
          "SUPER SHIFT, minus, Reset zoom, exec, ${hyprctl} -q keyword cursor:zoom_factor 1"

          # shell.
          "SUPER, tab, Open the launcher, exec,  ${noctalia} launcher toggle"
          "SUPER, ESCAPE, Open the session menu, exec, ${noctalia} sessionMenu toggle"
          "SUPER, C, Open the wallpaper menu, exec, ${noctalia} wallpaper toggle"
          "SUPER, O, Open the notification history, exec, ${noctalia} notifications toggleHistory"
          "SUPER, U, Open the control center, exec, ${noctalia} controlCenter toggle"
          "SUPER, G, Open the emoji picker in the launcher, exec, ${noctalia} launcher emoji"
          "SUPER SHIFT, V, Open the clipboard history in the launcher, exec, ${noctalia} launcher clipboard"
          "SUPER, Y, Inhibit idle, exec, ${noctalia} idleInhibitor toggle"

          # screenshots.
          "SUPER SHIFT, S, Screenshot selected region, exec, ${hyprshot} -m region -z -o ${screenshotDir}/region"
          "SUPER, Print, Screenshot entire monitor, exec, ${hyprshot} -m output -c -o ${screenshotDir}/output"

          # colorpicker.
          "SUPER SHIFT, X, Color picker, exec, ${hyprpicker} -n -a -r -q -l"

          # applications.
          "SUPER, Return, Open the terminal, exec, ${app2unit} ${ghostty}"
          "SUPER, E, Open the file manager, exec, ${app2unit} ${thunar}"
          "SUPER, N, Open discord, exec, ${app2unit} ${equibop}"
          "SUPER, B, Open the browser, exec, ${app2unit} ${zen-browser}"
          "SUPER, M, Open steam, exec, ${app2unit} ${steam}"

          # toggle groups.
          "SUPER, X, Toggle window grouping, togglegroup"
          "SUPER ALT, X, Move active window out of group, moveoutofgroup"

          # join groups.
          "SUPER ALT, LEFT, Move window to group on left, moveintogroup, l"
          "SUPER ALT, RIGHT, Move window to group on right, moveintogroup, r"
          "SUPER ALT, UP, Move window to group on top, moveintogroup, u"
          "SUPER ALT, DOWN, Move window to group on bottom, moveintogroup, d"

          "SUPER ALT, H, Move window to group on left, moveintogroup, l"
          "SUPER ALT, L, Move window to group on right, moveintogroup, r"
          "SUPER ALT, K, Move window to group on top, moveintogroup, u"
          "SUPER ALT, J, Move window to group on bottom, moveintogroup, d"

          # navigate a single set of grouped windows.
          "SUPER ALT, TAB, Next window in group, changegroupactive, f"
          "SUPER ALT SHIFT, TAB, Previous window in group, changegroupactive, b"

          # scroll through a set of grouped windows with super + alt + scroll.
          "SUPER ALT, mouse_down, Next window in group, changegroupactive, f"
          "SUPER ALT, mouse_up, Previous window in group, changegroupactive, b"

          # activate window in a group by number.
          "SUPER ALT, 1, Switch to group window 1, changegroupactive, 1"
          "SUPER ALT, 2, Switch to group window 2, changegroupactive, 2"
          "SUPER ALT, 3, Switch to group window 3, changegroupactive, 3"
          "SUPER ALT, 4, Switch to group window 4, changegroupactive, 4"
          "SUPER ALT, 5, Switch to group window 5, changegroupactive, 5"
        ];

      binddm = [
        # window manipulation.
        "SUPER, mouse:272, Move window with mouse, movewindow"
        "SUPER, mouse:273, Resize window with mouse, resizewindow"
      ];

      bindde = [
        # zoom.
        "SUPER, equal, Zoom in, exec, ${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${gawk} '/^float.*/ {print $2 * 1.1}')"
        "SUPER, minus, Zoom out, exec, ${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${gawk} '/^float.*/ {print $2 * 0.9}')"

        "SUPER, mouse_down, Zoom in with mouse, exec, ${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${gawk} '/^float.*/ {print $2 * 1.1}')"
        "SUPER, mouse_up, Zoom out with mouse, exec, ${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${gawk} '/^float.*/ {print $2 * 0.9}')"

        # expand/shrink windows.
        "SUPER CTRL, LEFT, Expand/shrink window left, resizeactive, -20 0"
        "SUPER CTRL, RIGHT, Expand/shrink window left, resizeactive, 20 0"
        "SUPER CTRL, UP, Expand/shrink window up, resizeactive, 0 -20"
        "SUPER CTRL, DOWN, Expand/shrink window down, resizeactive, 0 20"

        "SUPER CTRL, H, Expand/shrink window left, resizeactive, -20 0"
        "SUPER CTRL, L, Expand/shrink window left, resizeactive, 20 0"
        "SUPER CTRL, K, Expand/shrink window up, resizeactive, 0 -20"
        "SUPER CTRL, J, Expand/shrink window down, resizeactive, 0 20"
      ];

      # xf86 keybinds.
      binddel =
        let
          cfgBrightness = config.hyprland.brightness.enable;
        in
        [
          "XF86AudioMute, Volume mute, exec, ${noctalia} volume muteOutput"
          "XF86AudioRaiseVolume, Volume up, exec, ${noctalia} volume increase"
          "XF86AudioLowerVolume, Volume down, exec, ${noctalia} volume decrease"
        ]
        ++ optionals cfgBrightness [
          "XF86MonBrightnessUp, Brightness up, exec, brightnessctl set 1%+"
          "XF86MonBrightnessDown, Brightness down, exec, brightnessctl set 1%-"
        ];
    };
}
