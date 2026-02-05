{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
# keybindings for hyprland including workspace, window, and media controls.
let
  inherit
    (lib)
    getExe
    getExe'
    mkEnableOption
    optionalString
    ;
  inherit (pkgs) callPackage;

  inherit (config.xdg) configHome;
in {
  options.hyprland.brightness.enable = mkEnableOption "Enable function-row (F-keys) for brightness keybindings.";

  # generate hyprland binding lists and helpers.
  config = {
    # allow focus cycling while a window is fullscreen.
    wayland.windowManager.hyprland.settings.binds.movefocus_cycles_fullscreen = true;

    # keep keybinds in a separate file for parsing tools.
    xdg.configFile."hypr/keybinds.conf".text = let
      gawk = getExe pkgs.gawk;
      hyprctl = getExe' osConfig.programs.hyprland.package "hyprctl";

      qs = getExe' config.programs.quickshell.package ".quickshell-wrapped";
      noctalia = "${getExe' config.programs.noctalia-shell.package "noctalia-shell"} ipc call";

      performantMode = callPackage ./scripts/_performant-mode.nix {inherit osConfig;};
      thunar = getExe pkgs.thunar;
      equibop = getExe config.programs.nixcord.equibop.package;
      ghostty = "${getExe config.programs.ghostty.package} +new-window";
      hyprpicker = getExe config.programs.hyprshot.package;
      hyprshot = getExe config.programs.hyprshot.package;
      steam = getExe osConfig.programs.steam.package;
      zen-browser = getExe config.programs.zen-browser.package;
      app2unit = "${getExe config.programs.noctalia-shell.app2unit.package} --";
      brightnessctl = getExe pkgs.brightnessctl;

      cfgBrightness = config.hyprland.brightness.enable;
      screenshotDir = "${config.xdg.userDirs.pictures}/screenshot";

      zoomIn = "${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${gawk} '/^float.*/ {print $2 * 1.1}')";
      zoomOut = "${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${gawk} '/^float.*/ {print $2 * 0.9}')";
    in
      ''
        # 1. APPLICATIONS
        bind = SUPER, Return, exec, ${app2unit} ${ghostty} #"Terminal"
        bind = SUPER, E, exec, ${app2unit} ${thunar} #"File manager"
        bind = SUPER, N, exec, ${app2unit} ${equibop} #"Discord"
        bind = SUPER, B, exec, ${app2unit} ${zen-browser} #"Browser"
        bind = SUPER, M, exec, ${app2unit} ${steam} #"Steam"

        # 2. SHELL
        bind = SUPER, TAB, exec, ${noctalia} launcher toggle #"Launcher"
        bind = SUPER, ESCAPE, exec, ${noctalia} sessionMenu toggle #"Session menu"
        bind = SUPER, C, exec, ${noctalia} wallpaper toggle #"Wallpaper menu"
        bind = SUPER, O, exec, ${noctalia} notifications toggleHistory #"Notification history"
        bind = SUPER, U, exec, ${noctalia} controlCenter toggle #"Control center"
        bind = SUPER, G, exec, ${noctalia} launcher emoji #"Emoji picker"
        bind = SUPER SHIFT, V, exec, ${noctalia} launcher clipboard #"Clipboard history"
        bind = SUPER, Y, exec, ${noctalia} idleInhibitor toggle #"Idle inhibitor"

        # 3. WORKSPACES (SWITCH)
        bind = SUPER, 1, split:workspace, 1 #"Workspace 1"
        bind = SUPER, 2, split:workspace, 2 #"Workspace 2"
        bind = SUPER, 3, split:workspace, 3 #"Workspace 3"
        bind = SUPER, 4, split:workspace, 4 #"Workspace 4"
        bind = SUPER, 5, split:workspace, 5 #"Workspace 5"
        bind = SUPER, 6, split:workspace, 6 #"Workspace 6"
        bind = SUPER, 7, split:workspace, 7 #"Workspace 7"
        bind = SUPER, 8, split:workspace, 8 #"Workspace 8"

        # 4. WORKSPACES (MOVE)
        bind = SUPER SHIFT, 1, split:movetoworkspace, 1 #"Move to workspace 1"
        bind = SUPER SHIFT, 2, split:movetoworkspace, 2 #"Move to workspace 2"
        bind = SUPER SHIFT, 3, split:movetoworkspace, 3 #"Move to workspace 3"
        bind = SUPER SHIFT, 4, split:movetoworkspace, 4 #"Move to workspace 4"
        bind = SUPER SHIFT, 5, split:movetoworkspace, 5 #"Move to workspace 5"
        bind = SUPER SHIFT, 6, split:movetoworkspace, 6 #"Move to workspace 6"
        bind = SUPER SHIFT, 7, split:movetoworkspace, 7 #"Move to workspace 7"
        bind = SUPER SHIFT, 8, split:movetoworkspace, 8 #"Move to workspace 8"

        # 5. WORKSPACES (MOVE SILENT)
        bind = SUPER CTRL, 1, split:movetoworkspacesilent, 1 #"Move to workspace 1 (silent)"
        bind = SUPER CTRL, 2, split:movetoworkspacesilent, 2 #"Move to workspace 2 (silent)"
        bind = SUPER CTRL, 3, split:movetoworkspacesilent, 3 #"Move to workspace 3 (silent)"
        bind = SUPER CTRL, 4, split:movetoworkspacesilent, 4 #"Move to workspace 4 (silent)"
        bind = SUPER CTRL, 5, split:movetoworkspacesilent, 5 #"Move to workspace 5 (silent)"
        bind = SUPER CTRL, 6, split:movetoworkspacesilent, 6 #"Move to workspace 6 (silent)"
        bind = SUPER CTRL, 7, split:movetoworkspacesilent, 7 #"Move to workspace 7 (silent)"
        bind = SUPER CTRL, 8, split:movetoworkspacesilent, 8 #"Move to workspace 8 (silent)"

        # 6. WINDOW MANAGEMENT
        bind = SUPER, F, fullscreen, #"Toggle fullscreen"
        bind = SUPER, V, togglefloating, #"Toggle floating"
        bind = SUPER, S, togglesplit, #"Toggle split"
        bind = SUPER, P, pseudo, #"Toggle pseudo"
        bind = SUPER, Q, killactive, #"Close window"
        bind = SUPER SHIFT, O, split:grabroguewindows, #"Grab rogue windows"

        # 7. WINDOW MOVE
        bind = SUPER SHIFT, LEFT, movewindow, l #"Move window left"
        bind = SUPER SHIFT, RIGHT, movewindow, r #"Move window right"
        bind = SUPER SHIFT, UP, movewindow, u #"Move window up"
        bind = SUPER SHIFT, DOWN, movewindow, d #"Move window down"

        bind = SUPER SHIFT, H, movewindow, l #"Move window left"
        bind = SUPER SHIFT, L, movewindow, r #"Move window right"
        bind = SUPER SHIFT, K, movewindow, u #"Move window up"
        bind = SUPER SHIFT, J, movewindow, d #"Move window down"

        # 8. WINDOW FOCUS
        bind = SUPER, LEFT, movefocus, l #"Focus left"
        bind = SUPER, RIGHT, movefocus, r #"Focus right"
        bind = SUPER, UP, movefocus, u #"Focus up"
        bind = SUPER, DOWN, movefocus, d #"Focus down"

        bind = SUPER, H, movefocus, l #"Focus left"
        bind = SUPER, L, movefocus, r #"Focus right"
        bind = SUPER, K, movefocus, u #"Focus up"
        bind = SUPER, J, movefocus, d #"Focus down"

        # 9. GROUPS
        bind = SUPER, X, togglegroup, #"Toggle group"
        bind = SUPER ALT, X, moveoutofgroup, #"Move out of group"

        bind = SUPER ALT, LEFT, moveintogroup, l #"Move into group (left)"
        bind = SUPER ALT, RIGHT, moveintogroup, r #"Move into group (right)"
        bind = SUPER ALT, UP, moveintogroup, u #"Move into group (up)"
        bind = SUPER ALT, DOWN, moveintogroup, d #"Move into group (down)"

        bind = SUPER ALT, H, moveintogroup, l #"Move into group (left)"
        bind = SUPER ALT, L, moveintogroup, r #"Move into group (right)"
        bind = SUPER ALT, K, moveintogroup, u #"Move into group (up)"
        bind = SUPER ALT, J, moveintogroup, d #"Move into group (down)"

        bind = SUPER ALT, TAB, changegroupactive, f #"Next in group"
        bind = SUPER ALT SHIFT, TAB, changegroupactive, b #"Previous in group"
        bind = SUPER ALT, mouse_down, changegroupactive, f #"Next in group"
        bind = SUPER ALT, mouse_up, changegroupactive, b #"Previous in group"

        bind = SUPER ALT, 1, changegroupactive, 1 #"Focus group window 1"
        bind = SUPER ALT, 2, changegroupactive, 2 #"Focus group window 2"
        bind = SUPER ALT, 3, changegroupactive, 3 #"Focus group window 3"
        bind = SUPER ALT, 4, changegroupactive, 4 #"Focus group window 4"
        bind = SUPER ALT, 5, changegroupactive, 5 #"Focus group window 5"

        # 10. LAYOUT AND RESIZE
        binde = SUPER CTRL, LEFT, resizeactive, -20 0 #"Resize left"
        binde = SUPER CTRL, RIGHT, resizeactive, 20 0 #"Resize right"
        binde = SUPER CTRL, UP, resizeactive, 0 -20 #"Resize up"
        binde = SUPER CTRL, DOWN, resizeactive, 0 20 #"Resize down"

        binde = SUPER CTRL, H, resizeactive, -20 0 #"Resize left"
        binde = SUPER CTRL, L, resizeactive, 20 0 #"Resize right"
        binde = SUPER CTRL, K, resizeactive, 0 -20 #"Resize up"
        binde = SUPER CTRL, J, resizeactive, 0 20 #"Resize down"

        bindm = SUPER, mouse:272, movewindow #"Move window"
        bindm = SUPER, mouse:273, resizewindow #"Resize window"

        # 11. SCREENSHOTS AND COLOR
        bind = SUPER SHIFT, S, exec, ${hyprshot} -m region -z -o ${screenshotDir}/region #"Screenshot (region)"
        bind = SUPER, Print, exec, ${hyprshot} -m output -c -o ${screenshotDir}/output #"Screenshot (output)"
        bind = SUPER SHIFT, X, exec, ${hyprpicker} -n -a -r -q -l #"Color picker"

        # 12. SYSTEM
        bind = SUPER SHIFT, TAB, exec, ${qs} ipc -c overview call overview toggle #"Overview"
        bind = SUPER, F2, exec, ${noctalia} plugin togglePanel keybind-cheatsheet #"Keybind cheatsheet"
        bind = SUPER, F1, exec, ${getExe performantMode} #"Performant mode"

        # 13. CURSOR ZOOM
        binde = SUPER, equal, exec, ${zoomIn} #"Zoom in"
        binde = SUPER, minus, exec, ${zoomOut} #"Zoom out"

        bind = SUPER, mouse_down, exec, ${zoomIn} #"Zoom in"
        bind = SUPER, mouse_up, exec, ${zoomOut} #"Zoom out"

        bind = SUPER SHIFT, mouse_down, exec, ${hyprctl} -q keyword cursor:zoom_factor 1 #"Reset zoom"
        bind = SUPER SHIFT, minus, exec, ${hyprctl} -q keyword cursor:zoom_factor 1 #"Reset zoom"

        # 14. MEDIA
        bindl = , XF86AudioMute, exec, ${noctalia} volume muteOutput #"Mute"
        bindel = , XF86AudioRaiseVolume, exec, ${noctalia} volume increase #"Volume up"
        bindel = , XF86AudioLowerVolume, exec, ${noctalia} volume decrease #"Volume down"
      ''
      # append brightness bindings when enabled.
      + optionalString cfgBrightness ''

        # 15. MEDIA (BRIGHTNESS)
        bindel = , XF86MonBrightnessUp, exec, ${brightnessctl} set 1%+ #"Brightness up"
        bindel = , XF86MonBrightnessDown, exec, ${brightnessctl} set 1%- #"Brightness down"
      '';

    wayland.windowManager.hyprland.extraConfig = ''
      source = ${configHome}/hypr/keybinds.conf
    '';
  };
}
